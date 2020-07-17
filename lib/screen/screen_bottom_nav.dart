import 'package:flutter/material.dart';
import 'package:stroom_simulator_vid/screen/screen_simulasi_pasang.dart';
import 'package:stroom_simulator_vid/screen/screen_simulasi_token.dart';
import 'package:stroom_simulator_vid/screen/screen_simulator_kwh.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedTab = 0;

  void _onTapedTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      SimKwhScreen(),
      SimPasangScreen(),
      SimBeliToken(),
    ];

    final _menuItem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.mobile_screen_share), title: Text("Daya")),
      BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on), title: Text("Pasang Baru")),
      BottomNavigationBarItem(icon: Icon(Icons.nfc), title: Text("Beli Token")),
    ];

    final _bottomBar = BottomNavigationBar(
      items: _menuItem,
      currentIndex: _selectedTab,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onTapedTab,
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.apps,
          color: Colors.amber,
        ),
        title: Text("Stroom Simulator v1.0"),
      ),
      body: Center(
        child: _listPage[_selectedTab],
      ),
      bottomNavigationBar: _bottomBar,
    );
  }
}
