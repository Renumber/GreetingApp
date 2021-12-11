import 'dart:core';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/greeting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GreetingProvider with ChangeNotifier {
  Map<String, List<Greeting>> greetings;
  List<String> favoriteIndexes;
  List<Greeting> favoriteList = [];
  List<Greeting> mostRecList = [];

  GreetingProvider({required this.greetings, required this.favoriteIndexes}) {
    greetings.forEach((key, value) {
      value.forEach((element) {
        mostRecList.add(element);
        if (favoriteIndexes.contains("${element.greetingID}")) {
          element.isRec = true;
          favoriteList.add(element);
        }
      });
    });
    sortMostRec();
  }

  void addGreeting(String category, Greeting greeting) {
    if (greetings.keys.contains(category)) {
      greetings[category]!.add(greeting);
    } else {
      print("greetingProvider/add : $category없음");
    }
  }

  void deleteGreeting(String category, Greeting greeting) {
    if (greetings.keys.contains(category)) {
      greetings[category]!.remove(greeting);
    } else {
      print("greetingProvider/delete : $category없음");
    }
  }

  void sortGreeting(String category) {
    greetings[category]!.sort((a, b) => b.recommend.compareTo(a.recommend));
    notifyListeners();
  }

  void sortMostRec() {
    mostRecList.sort((a, b) => b.recommend.compareTo(a.recommend));
    notifyListeners();
  }

  void editFavoriteIndexes(int greetingID) {
    greetings.forEach((key, value) {
      value.forEach((element) {
        if (element.greetingID == greetingID) {
          if (favoriteIndexes.contains("$greetingID")) {
            element.decreaseRec();
            favoriteIndexes.remove("$greetingID");
            favoriteList.remove(element);
          } else {
            element.increaseRec();
            favoriteIndexes.add("$greetingID");
            favoriteList.add(element);
          }
        }
      });
    });
    sortMostRec();
    updateFavoriteSP();
  }

  Future<void> updateFavoriteSP() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("favorite", favoriteIndexes);
  }

  List<Widget> getFavoriteGreetings(BuildContext context) {
    List<Widget> widgets = [];
    if (favoriteList.isEmpty) {
      widgets.add(Center(child: Text("즐겨찾기한 항목이 없습니다.")));
    }
    favoriteList.forEach((element) {
      widgets.add(element.getContainer(context));
    });
    return widgets;
  }

  List<Widget> searchGreetings(BuildContext context, String searchStr) {
    List<Widget> widgets = [];
    greetings.forEach((key, value) {
      value.forEach((element) {
        if (element.content.contains(searchStr)) {
          widgets.add(element.getContainer(context));
        } else if (element.category.contains(searchStr)) {
          widgets.add(element.getContainer(context));
        } else if (element.relation.contains(searchStr)) {
          widgets.add(element.getContainer(context));
        }
      });
    });
    return widgets;
  }

  List<Widget> getRecGreetings(BuildContext context, String relation, String category) {
    List<Widget> widgets = [];
    List<Greeting> recGreetings = [];
    greetings.forEach((key, value) {
      if (key == category) {
        value.forEach((element) {
          if (element.relation == relation) {
            recGreetings.add(element);
          }
        });
      }
    });
    recGreetings.sort((a, b) => b.recommend.compareTo(a.recommend));
    if (recGreetings.isEmpty) {
      widgets.add(Text("해당 조건을 충족하는 인사말이 없습니다."));
    }
    recGreetings.forEach((element) {
      widgets.add(element.getContainer(context));
    });
    return widgets;
  }

  List<Widget> getMostCategory(BuildContext context, String category) {
    greetings[category]!.sort((a, b) => b.recommend.compareTo(a.recommend));
    List<Widget> widgets = [];
    int len = greetings[category]!.length;
    len = min(3, len);
    for (int i = 0; i < len; i++) {
      widgets.add(greetings[category]![i].getContainer(context));
    }
    return widgets;
  }

  List<Widget> getAllCategory(BuildContext context, String category) {
    greetings[category]!.sort((a, b) => b.recommend.compareTo(a.recommend));
    List<Widget> widgets = [];
    int len = greetings[category]!.length;
    for (int i = 0; i < len; i++) {
      widgets.add(greetings[category]![i].getContainer(context));
    }
    return widgets;
  }

  List<Widget> getMostRec(BuildContext context) {
    List<Widget> widgets = [];
    mostRecList.forEach((element) {
      widgets.add(element.getContainer(context));
    });
    return widgets;
  }
}
