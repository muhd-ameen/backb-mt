import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xffFFFFFF),
      type: BottomNavigationBarType
          .fixed, // this will be set when a new tab is tapped
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey.shade500,
      items: [
        BottomNavigationBarItem(
          icon: new ImageIcon(
            AssetImage('assets/icons/wlogo.png'),
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_bag_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
