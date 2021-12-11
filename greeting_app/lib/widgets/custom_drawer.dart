import 'package:flutter/material.dart';
import 'package:greeting_app/constants.dart';
import 'package:greeting_app/providers/user.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int sel = context.read<User>().selectedIndex;
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: kMainColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    "인사말추천앱",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                context.read<User>().changeSelectedIndex(0);
                Navigator.pop(context);
              },
              child: Text(
                "메인메뉴",
                style: TextStyle(fontSize: 16.0, fontWeight: sel == 0 ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                context.read<User>().changeSelectedIndex(1);
                Navigator.pop(context);
              },
              child: Text(
                "카테고리별 인사말",
                style: TextStyle(fontSize: 16.0, fontWeight: sel == 1 ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                context.read<User>().changeSelectedIndex(2);
                Navigator.pop(context);
              },
              child: Text(
                "적절한 인사말 추천",
                style: TextStyle(fontSize: 16.0, fontWeight: sel == 2 ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                context.read<User>().changeSelectedIndex(3);
                Navigator.pop(context);
              },
              child: Text(
                "즐겨찾기",
                style: TextStyle(fontSize: 16.0, fontWeight: sel == 3 ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                context.read<User>().changeSelectedIndex(4);
                Navigator.pop(context);
              },
              child: Text(
                "상황별 예절",
                style: TextStyle(fontSize: 16.0, fontWeight: sel == 4 ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Divider(
              height: 1.0,
              thickness: 1.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                context.read<User>().changeSelectedIndex(5);
                Navigator.pop(context);
              },
              child: Text(
                "설정",
                style: TextStyle(fontSize: 16.0, fontWeight: sel == 5 ? FontWeight.bold : FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
