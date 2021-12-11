import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/constants.dart';
import 'package:greeting_app/providers/greeting_provider.dart';
import 'package:greeting_app/widgets/custom_drawer.dart';

import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text(
          "즐겨찾기",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        children: getFavorites(),
      ),
    );
  }

  List<Widget> getFavorites() {
    return context.watch<GreetingProvider>().getFavoriteGreetings(context);
  }
}
