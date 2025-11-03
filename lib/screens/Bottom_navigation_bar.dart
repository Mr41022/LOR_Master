import 'package:flutter/material.dart';

class bottomNavigationBarScreen extends StatefulWidget {
  const bottomNavigationBarScreen(
      {super.key,
      required int currentIndex,
      required void Function() onTap,
      required int elevation,
      required List<BottomNavigationBarItem> items});

  @override
  State<bottomNavigationBarScreen> createState() =>
      _bottomNavigationBarScreenState();
}

class _bottomNavigationBarScreenState extends State<bottomNavigationBarScreen> {
  int _index = 0;

  // Right now nable to connect will try to minimize the code later
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch (_index) {
      case 0:
        child = child;
        break;

      case 1:
        child = child;
        break;

      case 1:
        child = child;
        break;
    }
    return Scaffold(bottomNavigationBar: _bottomTab());
  }

  Widget _bottomTab() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index) => setState(() => _index = index),
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: 'Add Request'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
