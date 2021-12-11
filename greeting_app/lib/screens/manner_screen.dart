import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/providers/greeting_provider.dart';
import 'package:greeting_app/providers/user.dart';
import 'package:greeting_app/widgets/custom_drawer.dart';
import 'package:greeting_app/constants.dart';

import 'package:provider/provider.dart';

class MannerScreen extends StatefulWidget {
  @override
  _MannerScreenState createState() => _MannerScreenState();
}

class Manner {
  String category;
  List<String> manners;

  Manner({required this.category, required this.manners});

  Widget getExpansionTile(BuildContext context) {
    return ExpansionTile(
      title: Text(this.category),
      children: <Widget>[
        ListView.builder(
          itemCount: manners.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(this.manners[index]),
            );
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        )
      ],
    );
  }
}

class _MannerScreenState extends State<MannerScreen> {
  @override
  List<Manner> manners = <Manner>[
    Manner(category: "결혼식", manners: [
      "정장 혹은 깔끔한 복장으로 참여하세요. 여성분들은 흰색 계통의 옷은 피해야 합니다",
      "과도하게 화려한 악세사리는 지양하세요",
      "축의금은 관계에 따라 3,5,7,10만 원의 홀수 금액으로 냅니다",
      "가능하면 예식 시작보다 일찍 도착해서 여유있게 인사하세요",
      "축의하고 결혼당사자 부모님께 인사드리고 신랑 혹은 신부 대기실에 방문해서 축하해 주세요",
      "축하의 자리인 만큼 불필요한 언행에 주의하세요",
      "관계에 따라 예식이 끝나고 신랑 신부가 떠날 때까지 자리를 지켜줍니다"
    ]),
    Manner(category: "장례식", manners: [
      "검은 계통의 양복을 기본으로 합니다",
      "최소한 검은 계통의 옷을 준비합니다",
      "학생의 경우 교복도 괜찮습니다",
      "도착하면 외투와 모자를 미리 벗습니다",
      "안내에 따라 부의록을 작성합니다",
      "분향 및 헌화 방법은 향나무를 깎은 나무향일 경우는 오른손으로 향을 집어 향로 위에 놓는데 이 때 왼손으로 오른 손목을 받칩니다",
      "선향(막대향)일 경우 하나나 둘을 집어 촛불에 불을 붙인 다음 손가락으로 가만히 잡아서 끄든지 왼손으로 가볍게 흔들어 끄고 절대 입으로 불지 않습니다. 다음으로 두손으로 공손히 향로에 꽂는데 선향은 하나로 충분하지만 여러 개일 경우 반드시 하나씩 꽂아야 합니다",
      "헌화를 할 때는 오른손으로 꽃줄기 하단을 가볍게 잡고 왼손 바닥으로 오른손을 받쳐 들어 두 손으로 공손히 꽃 봉우리가 영정 쪽으로 향하게 하여 재단위에 헌화 한 뒤 잠깐 묵념 및 기도를 한다",
      "영좌 앞에 일어서서 잠깐 묵념 또는 두 번 절합니다",
      "영좌에서 물러나 상주와 맞절을 합니다. 종교에 따라 절을 하지 않는 경우는 정중히 고개를 숙여 예를 표합니다",
      "기독교는 준비된 국화꽃을 들고 고인영정 앞에 헌화한 후 뒤로 한 걸음 물러서 15도 각도로 고개 숙여 잠시동안 묵념을 드린 후 상주와 맞절을 합니다",
      "천주교는 국화꽃을 들고 고인영정 앞에 헌화한 후 뒤로 한 걸을 물러서서 15도 각도로 고개 숙여 잠시동안 묵념을 드린 다음 준비된 향을 집어서 불을 붙인 다음 향을 좌우로 흔들어 불꽃을 끕니다. 한쪽 무릎을 끓고 향로에 향을 정중히 꽂고 일어나 한 걸음 뒤로 물러서 절을 올립니다. 절을 올린 후에 상주와 맞절을 합니다",
      "불교는 영정 앞에 무릎을 끓고 앉아 준비된 향을 집어서 불을 붙인 다음 향을 좌우로 흔들어 불꽃을 끄고 향로에 향을 정중히 꽂고 일어나 한걸음 뒤로 물러나 절을 올립니다. 절을 올린 후에 상주와 맞절을 합니다",
      "문상이 끝나면 두세 걸음 물러나 몸을 돌려 나옵니다",
      "상주와 유가족과의 관계에 따라 유감을 짧게라도 표합니다",
      "준비한 부의금을 부의합니다"
    ]),
    Manner(category: "명절", manners: ["어른들이 함께 하는 자리인 만큼 언행에 주의하세요", "오랜만에 보는 가족들에게 반갑게 대해주세요", "가족들이라도 상호 존중하며 보내세요"]),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        title: Text(
          "상황별 예절",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          itemCount: this.manners.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: this.manners[index].getExpansionTile(context),
            );
          },
        ),
      ),
    );
  }
}
