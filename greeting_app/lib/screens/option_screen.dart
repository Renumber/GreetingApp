import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/widgets/custom_drawer.dart';
import 'package:greeting_app/constants.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class OptionScreen extends StatefulWidget {
  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          centerTitle: true,
          title: Text(
            "설정",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: CustomDrawer(),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 25.0),
          children: [
            feedbackContainer("피드백"),
            SizedBox(height: 10.0),
            infoContainer("정보", "제작자\n서울시립대학교 컴퓨터과학부 소프트웨어공학수업 4조"),
          ],
        ));
  }

  Widget feedbackContainer(String subject) {
    return GestureDetector(
        onTap: () {
          _sendEmail();
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
          child: Row(
            children: [
              Icon(Icons.markunread),
              SizedBox(
                width: 16.0,
              ),
              Text(
                subject,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  Widget infoContainer(String subject, String content) {
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
              return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                return Container(
                  height: 500,
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              "버전 : 1.0.0\n$content",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => LicensePage()));
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
                          child: Text("라이센스"),
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
          child: Row(
            children: [
              Icon(Icons.info),
              SizedBox(width: 16.0),
              Text(
                subject,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }

  void _sendEmail() async {
    final Email email = Email(
      body: '',
      subject: '[앱 문의]',
      recipients: ['take9805@uos.ac.kr'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title = "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.";
      String message = "take9805@uos.ac.kr\n\n위 메일 주소로 따로 문의 보내주시면 답변드리겠습니다 :D";
      _showDialog(title, message);
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
