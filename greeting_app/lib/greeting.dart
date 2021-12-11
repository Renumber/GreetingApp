import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/providers/greeting_provider.dart';
import 'package:share/share.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class Greeting {
  bool isRec = false;
  int greetingID;
  String documentID;
  String content;
  int recommend;
  String relation;
  String category;

  Greeting(
      {required this.greetingID,
      required this.documentID,
      required this.content,
      required this.recommend,
      required this.relation,
      required this.category});

  void increaseRec() {
    recommend++; //추후 변경 예정
    updateRecData();
  }

  void decreaseRec() {
    recommend--;
    updateRecData();
  }

  Future<void> updateRecData() async {
    return await FirebaseFirestore.instance.collection('greetingData2').doc(documentID).update({
      'recommend': recommend,
    });
  }

  void shareGreeting(String shareContent) {
    Share.share('$shareContent');
  }

  Widget getContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 600,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$category",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("add rec");
                                setState(() {
                                  this.isRec = !this.isRec;
                                });
                                context.read<GreetingProvider>().editFavoriteIndexes(greetingID);
                              },
                              child: Icon(isRec ? Icons.thumb_up : Icons.thumb_up_outlined),
                            ),
                            Text("$recommend")
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            "$content",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (content.contains("OO")) {
                          _displayTextInputDialog(context, "OOO");
                        } else if (content.contains("00")) {
                          _displayTextInputDialog(context, "000");
                        } else {
                          shareGreeting(content);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        margin: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          color: kMainColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("공유하기"),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
      child: Container(
        height: 50.0,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          "$content",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context, String str) async {
    String changeStr = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '보낼 상대방의 이름을 입력해 주세요',
              style: TextStyle(fontSize: 16.0),
            ),
            content: TextField(
              onChanged: (value) {
                changeStr = value;
              },
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('취소'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('공유'),
                onPressed: () {
                  String newContent = content.replaceAll(str, changeStr);
                  newContent = newContent.replaceAll(str.substring(1), changeStr);
                  Navigator.pop(context);
                  shareGreeting(newContent);
                },
              ),
            ],
          );
        });
  }

  String toString() {
    return "$greetingID, $content, rec : $recommend, rel :$relation, cate :$category";
  }
}
