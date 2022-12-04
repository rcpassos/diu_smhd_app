import 'package:diu_smhd_app/pages/AlertsPage.dart';
import 'package:diu_smhd_app/widgets/HomeTabsWidget.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeTabsWidget(),
    HomeTabsWidget(),
    HomeTabsWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNotificationsButtonTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AlertsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMHD'),
        centerTitle: false,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: _onNotificationsButtonTapped,
                child: const Icon(
                  Icons.notifications,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lan),
            label: 'Dispositivo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Definições',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}