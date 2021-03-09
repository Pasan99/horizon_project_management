import 'package:flutter/material.dart';
import 'package:horizon_project_management/values/colors.dart';

import 'fragments/home_page_fragment.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selectedItemIndex = 0;

  List<Widget> fragments = [
    HomePageFragment(),
    HomePageFragment(),
    HomePageFragment(),
    HomePageFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if (_selectedItemIndex != 0){
          _onItemTapped(0);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
          bottomNavigationBar: Row(
            children: <Widget>[
              buildNavItem(Icon(Icons.assignment), 0),
              buildNavItem(Icon(Icons.stop_circle_rounded), 1),
              buildNavItem(Icon(Icons.people), 2),
              buildNavItem(Icon(Icons.person), 3),
            ],
          ),
          body: fragments[_selectedItemIndex]
      ),
    );
  }

  Widget buildNavItem(Icon icon, index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: _selectedItemIndex == index ? BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 4, color: AppColors.MAIN_COLOR)
          ),
          gradient: LinearGradient(
              colors: [
                AppColors.MAIN_COLOR.withOpacity(0.2),
                AppColors.MAIN_COLOR.withOpacity(0.015)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
          ),
        ) : BoxDecoration (
            color: Colors.white
        ),
        child: icon,
      ),
    );
  }
}
