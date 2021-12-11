import 'dart:async';
import 'dart:io';

import 'package:greeting_app/providers/user.dart';
import 'package:greeting_app/screens/category_screen.dart';
import 'package:greeting_app/screens/favorite_screen.dart';
import 'package:greeting_app/screens/main_screen.dart';
import 'package:greeting_app/screens/manner_screen.dart';
import 'package:greeting_app/screens/option_screen.dart';
import 'package:greeting_app/screens/recommend_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _mainScreen = GlobalKey<NavigatorState>();
  final _categoryScreen = GlobalKey<NavigatorState>();
  final _recommendScreen = GlobalKey<NavigatorState>();
  final _favoriteScreen = GlobalKey<NavigatorState>();
  final _mannerScreen = GlobalKey<NavigatorState>();
  final _optionScreen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _willPopCallback,
          child: IndexedStack(
            index: context.watch<User>().selectedIndex,
            children: <Widget>[
              Navigator(
                key: _mainScreen,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => MainScreen(),
                ),
              ),
              Navigator(
                key: _categoryScreen,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => CategoryScreen(),
                ),
              ),
              Navigator(
                key: _recommendScreen,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => RecommendScreen(),
                ),
              ),
              Navigator(
                key: _favoriteScreen,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => FavoriteScreen(),
                ),
              ),
              Navigator(
                key: _mannerScreen,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => MannerScreen(),
                ),
              ),
              Navigator(
                key: _optionScreen,
                onGenerateRoute: (route) => MaterialPageRoute(
                  settings: route,
                  builder: (context) => OptionScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    var flag = false;
    var cnt = 0;
    switch (context.read<User>().selectedIndex) {
      case 0:
        _mainScreen.currentState!.popUntil((route) {
          print("route : ${route.settings.name}");
          print("cnt : $cnt");
          if (route.settings.name == null && cnt == 0) {
            cnt = 1;
            return route.isFirst;
          } else if (cnt == 0) {
            flag = true;
          } else {
            cnt = 1;
          }
          return true;
        });
        break;
      case 1:
        print("cate");
        if (context.read<User>().category.isEmpty) {
          context.read<User>().changeSelectedIndex(0);
        } else {
          context.read<User>().changeIndexCategory("");
        }
        break;
      case 2:
        print("rec");
        context.read<User>().changeSelectedIndex(0);
        break;
      case 3:
        print("fav");
        context.read<User>().changeSelectedIndex(0);
        break;
      case 4:
        print("man");
        context.read<User>().changeSelectedIndex(0);
        break;
      case 5:
        print("opt");
        context.read<User>().changeSelectedIndex(0);
        break;
      default:
        print("def");
        context.read<User>().changeSelectedIndex(0);
        break;
    }
    if (flag == true) {
      exit(0);
    }
    return Future(() => false);
  }
}
