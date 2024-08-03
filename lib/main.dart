import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'add_listing.dart';
import 'home.dart';
import 'search.dart';
import 'paid_skills.dart';
import 'leaderboard.dart';
import 'notification.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListingsProvider(prefs),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SkillSWAP',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: prefs.getString('email') != null ? HomePage() : LoginPage(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomePage(),
          '/add': (context) => AddListingPage(),
          '/search': (context) => SearchPage(),
          '/paid': (context) => PaidSkillsPage(),
          '/leaderboard': (context) => LeaderboardPage(),
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/swapper.png',
        height: 55, // adjust the height as needed
      ),
      backgroundColor: Colors.purple,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_active, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class ListingsProvider with ChangeNotifier {
  final SharedPreferences prefs;
  List<Map<String, dynamic>> _listings = [];

  ListingsProvider(this.prefs) {
    _loadListings();
    _addPredefinedPaidSkills();
  }

  void _loadListings() {
    String? listingsData = prefs.getString('listings');
    if (listingsData != null) {
      _listings = List<Map<String, dynamic>>.from(json.decode(listingsData));
    }
  }

  void _saveListings() {
    prefs.setString('listings', json.encode(_listings));
  }

  void _addPredefinedPaidSkills() {
    if (_listings.isEmpty) {
      _listings.addAll([
        // ... your existing predefined skills, make sure they have either 'cost' or 'neededSkill' based on 'isPaid'
        {
          'name': 'John Doe',
          'phone': '123-456-7890',
          'email': 'john@example.com',
          'photo': '',
          'location': 'New York',
          'skill': 'Web Development',
          'bio': 'Experienced web developer',
          'isPaid': true,
          'rating': 4.5,
          'cost': '50' // 'cost' because isPaid is true
        },
        {
          'name': 'Alice Johnson',
          'phone': '555-123-4567',
          'email': 'alice@example.com',
          'photo': '',
          'location': 'London',
          'skill': 'Gardening',
          'bio': 'Let\'s swap gardening tips!',
          'isPaid': false,
          'neededSkill':
              'Floral Design' // 'neededSkill' because isPaid is false
        },
        // ... add more predefined skills
      ]);
      _saveListings();
    }
  }

  List<Map<String, dynamic>> get listings => _listings;

  void addListing(String name, String phone, String email, String photo,
      String location, String skill, String bio, bool isPaid, double rating,
      [String? cost, String? neededSkill]) {
    _listings.add({
      'name': name,
      'phone': phone,
      'email': email,
      'photo': photo,
      'location': location,
      'skill': skill,
      'bio': bio,
      'isPaid': isPaid,
      'rating': rating,
      if (isPaid) 'cost': cost, // Add 'cost' only if isPaid is true
      if (!isPaid)
        'neededSkill': neededSkill, // Add 'neededSkill' only if isPaid is false
    });
    _saveListings();
    notifyListeners();
  }

  List<Map<String, dynamic>> get paidSkills =>
      _listings.where((listing) => listing['isPaid']).toList();

  List<Map<String, dynamic>> get swapSkills =>
      _listings.where((listing) => !listing['isPaid']).toList();

  List<Map<String, dynamic>> get topRatedSkills =>
      _listings..sort((a, b) => b['rating'].compareTo(a['rating']));

  List<Map<String, dynamic>> get topRatedPaidSkills {
    final sortedPaidSkills = List<Map<String, dynamic>>.from(paidSkills)
      ..sort((a, b) => b['rating'].compareTo(a['rating']));
    return sortedPaidSkills.take(10).toList();
  }
}
