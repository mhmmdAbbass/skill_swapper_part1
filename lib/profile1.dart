import 'package:flutter/material.dart';
import 'bottom_nav_bar_with_animation.dart';

class profile1 extends StatelessWidget {
  const profile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text("user profile will appear here, future work "),
      ),
      bottomNavigationBar: BottomNavBarWithAnimation(),
    );
  }
}
