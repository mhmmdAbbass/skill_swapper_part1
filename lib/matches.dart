import 'package:flutter/material.dart';
import 'main.dart';
import 'bottom_nav_bar_with_animation.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: Text('possible matches'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: (Center(
        child: Text(
          "this is there the matches skill will appear , future work",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      )),
      bottomNavigationBar: BottomNavBarWithAnimation(),
    );
  }
}
