import 'package:flutter/material.dart';
import 'addWorkout.dart';
import 'addcard.dart';
import 'editcard.dart';
import 'viewcards.dart'; // Make sure you import the ViewCards widget
import 'viewWorkouts.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ViewCards(),       // Display ViewCards screen
    AddCardScreen(),   // Display AddCard screen
    // EditCardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Firebase"),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Card',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.edit),
          //   label: 'Edit Card',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
