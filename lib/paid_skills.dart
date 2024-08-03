import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'profile.dart';
import 'bottom_nav_bar_with_animation.dart';

class PaidSkillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Paid Skills'),
      body: Consumer<ListingsProvider>(
        builder: (context, provider, child) {
          final paidSkills = provider.paidSkills;
          return ListView.builder(
            itemCount: paidSkills.length,
            itemBuilder: (context, index) {
              final listing = paidSkills[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  leading: Icon(
                    Icons.work, // You can change the icon
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
                          builder: (context) => ProfilePage(listing: listing),
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
      bottomNavigationBar: BottomNavBarWithAnimation(),
    );
  }
}
