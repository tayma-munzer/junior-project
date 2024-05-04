import 'package:flutter/material.dart';
import 'package:mobile/homepage.dart';
import 'package:mobile/add.dart';
import 'package:mobile/search.dart';
import 'package:mobile/personalaccount.dart';
import 'package:mobile/services_types.dart';
import 'package:mobile/colors.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Color _homeIconColor = Colors.white;
  Color _addIconColor = Colors.white;
  Color _searchIconColor = Colors.white;
  Color _accountIconColor = Colors.white;
  Color _CategoriesIconColor = Colors.white;

  void _updateIconColor(String icon) {
    setState(() {
      if (icon == 'home') {
        _homeIconColor = Colors.white;
        _addIconColor = Colors.white;
        _searchIconColor = Colors.white;
        _accountIconColor = Colors.white;
        _homeIconColor = Colors.black;
      } else if (icon == 'add') {
        _homeIconColor = Colors.white;
        _addIconColor = Colors.black;
        _searchIconColor = Colors.white;
        _accountIconColor = Colors.white;
      } else if (icon == 'search') {
        _homeIconColor = Colors.white;
        _addIconColor = Colors.white;
        _searchIconColor = Colors.black;
        _accountIconColor = Colors.white;
      } else if (icon == 'account') {
        _homeIconColor = Colors.white;
        _addIconColor = Colors.white;
        _searchIconColor = Colors.white;
        _accountIconColor = Colors.black;
      } else if (icon == 'categories') {
        _homeIconColor = Colors.white;
        _addIconColor = Colors.white;
        _searchIconColor = Colors.white;
        _accountIconColor = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appbarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, -1.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: BottomAppBar(
        color: AppColors.appbarColor,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: _homeIconColor),
              onPressed: () {
                _updateIconColor('home');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: _addIconColor),
              onPressed: () {
                _updateIconColor('add');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: _searchIconColor),
              onPressed: () {
                _updateIconColor('search');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: _accountIconColor),
              onPressed: () {
                _updateIconColor('account');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalAccount()));
              },
            ),
            IconButton(
              icon: Icon(Icons.category_rounded, color: _CategoriesIconColor),
              onPressed: () {
                _updateIconColor('account');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => services_types()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
