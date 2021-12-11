import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/constants.dart';
import 'package:greeting_app/providers/greeting_provider.dart';
import 'package:greeting_app/providers/user.dart';
import 'package:greeting_app/widgets/custom_drawer.dart';

import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String category = "";
  @override
  Widget build(BuildContext context) {
    category = context.watch<User>().category;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text(
          "카테고리별 인사말",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        children: category.isEmpty ? getCategories() : getOneCategory(),
      ),
    );
  }

  List<Widget> getCategories() {
    List<Widget> widgets = [];
    Iterable<String> keys = context.watch<GreetingProvider>().greetings.keys;
    keys.forEach((element) {
      widgets.add(Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$element",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<User>().changeIndexCategory(element);
                  },
                  child: Text(
                    "전체 보기>",
                    style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.6)),
                  ),
                )
              ],
            ),
          ),
          Column(children: context.watch<GreetingProvider>().getMostCategory(context, element)),
          SizedBox(height: 22.0)
        ],
      ));
    });
    return widgets;
  }

  List<Widget> getOneCategory() {
    List<Widget> widgets = [];
    widgets.add(Container(
        margin: EdgeInsets.only(bottom: 14.0),
        child: Text("$category", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))));
    widgets.add(Column(children: context.watch<GreetingProvider>().getAllCategory(context, category)));
    return widgets;
  }
}
