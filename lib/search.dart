import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'profile.dart';
import 'bottom_nav_bar_with_animation.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search skills',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
                borderRadius: BorderRadius.circular(25.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow effect
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by skill or location',
                  border: InputBorder.none, // Remove default underline
                  prefixIcon: Icon(Icons.search, color: Colors.purple),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Consumer<ListingsProvider>(
              builder: (context, provider, child) {
                final results = provider.listings.where((listing) {
                  final skill = listing['skill'].toLowerCase();
                  final location = listing['location'].toLowerCase();
                  return skill.contains(_searchTerm) ||
                      location.contains(_searchTerm);
                }).toList();

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final listing = results[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 3, // Add a subtle shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20.0),
                        leading: Icon(
                          Icons.work, // Replace with relevant icon
                          size: 40,
                          color: Colors.purple,
                        ),
                        title: Text(
                          listing['skill'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          listing['location'],
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.purple,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(listing: listing),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarWithAnimation(),
    );
  }
}
