import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/constants.dart';
import 'package:greeting_app/providers/greeting_provider.dart';
import 'package:greeting_app/widgets/custom_drawer.dart';

import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RecommendScreen extends StatefulWidget {
  @override
  _RecommendScreenState createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  String relation = "지인";
  String category = "크리스마스";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text(
          "적절한 인사말 추천",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        children: [
          Text(
            "상대방의 관계와 상황에 따라\n가장 적절한 인사말을\n추천해 드려요",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 18.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "관계",
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(width: 8.0),
              Flexible(
                child: Container(
                  height: 40.0,
                  child: Center(
                    child: DropdownSearch<String>(
                      selectedItem: relation,
                      mode: Mode.MENU,
                      showSearchBox: true,
                      showSelectedItems: true,
                      items: relationList,
                      dropdownSearchDecoration: InputDecoration(
                        // isDense: true,
                        contentPadding: EdgeInsets.only(left: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: kMainColor,
                      ),
                      onChanged: (data) {
                        setState(() {
                          relation = data!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                "상황",
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(width: 8.0),
              Flexible(
                child: Container(
                  height: 40.0,
                  child: Center(
                    child: DropdownSearch<String>(
                      selectedItem: category,
                      mode: Mode.MENU,
                      showSearchBox: true,
                      showSelectedItems: true,
                      items: categoryList,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: kMainColor,
                      ),
                      onChanged: (data) {
                        setState(() {
                          category = data!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Column(
            children: getRecGreetings(),
          )
        ],
      ),
    );
  }

  List<Widget> getRecGreetings() {
    return context.watch<GreetingProvider>().getRecGreetings(context, relation, category);
  }
}
