import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/providers/greeting_provider.dart';
import 'package:greeting_app/providers/user.dart';
import 'package:greeting_app/widgets/custom_drawer.dart';
import 'package:greeting_app/constants.dart';

import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String searchStr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        title: Text(
          "인사말추천앱",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: CustomDrawer(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        children: [
          Text(
            "상대방에게 가장 적절한 문구를\n검색해 보세요.",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 35,
            child: TextFormField(
              initialValue: searchStr,
              onChanged: (text) {
                setState(() {
                  searchStr = text;
                });
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: kMainColor,
              ),
            ),
          ),
          searchStr.isEmpty ? Container() : getSearch(searchStr),
          getSoon(),
          getBestRec(),
        ],
      ),
    );
  }

  Widget getSoon() {
    String season = "크리스마스";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "곧 $season입니다!!\n이런 문구는 어떤가요?",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  context.read<User>().changeIndexCategory(season);
                },
                child: Text(
                  "전체 보기>",
                  style: TextStyle(fontSize: 12.0, color: Colors.black.withOpacity(0.6)),
                ),
              )
            ],
          ),
        ),
        Column(children: context.watch<GreetingProvider>().getMostCategory(context, season))
      ],
    );
  }

  Widget getBestRec() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 14.0),
          child: Text(
            "가장 많은 추천을 받았아요",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: context.watch<GreetingProvider>().getMostRec(context))
      ],
    );
  }

  Widget getSearch(String searchStr) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(children: context.watch<GreetingProvider>().searchGreetings(context, searchStr)),
    );
  }
}
