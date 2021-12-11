import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/constants.dart';
import 'package:greeting_app/greeting.dart';
import 'package:greeting_app/main_page.dart';
import 'package:greeting_app/providers/greeting_provider.dart';
import 'package:greeting_app/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Map<String, List<Greeting>> greetings = await getGreetingsServer();
  List<String> favoriteIndexes = await getFavoriteFromSP();
  print("finfin");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
        ChangeNotifierProvider(create: (_) => GreetingProvider(greetings: greetings, favoriteIndexes: favoriteIndexes)),
      ],
      child: MyApp(),
    ),
  );
}

Future<Map<String, List<Greeting>>> getGreetingsServer() async {
  Map<String, List<Greeting>> greetings = {};
  categoryList.forEach((element) {
    greetings[element] = [];
  });
  var collection = FirebaseFirestore.instance.collection('greetingData2');
  var querySnapshot = await collection.get();
  int cnt = 0;
  print("len : ${querySnapshot.docs.length}");
  for (var queryDocumentSnapshot in querySnapshot.docs) {
    try {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      greetings[data['category']]!.add(Greeting(
          greetingID: data['ID'],
          documentID: queryDocumentSnapshot.id,
          content: data['content'],
          recommend: data['recommend'],
          relation: data['relation'],
          category: data['category']));
      print("${data['ID']}, ${cnt++}, ${queryDocumentSnapshot.id}");
    } catch (e) {
      print("error at ${queryDocumentSnapshot.id}");
    }
  }
  print("fin");
  return greetings;
}

Future<List<String>> getFavoriteFromSP() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList("favorite") ?? [];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greeting App',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: const TextTheme(
            subtitle1: TextStyle(fontSize: 12.0),
          )),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
