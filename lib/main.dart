import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Widgets/screen_SignIn.dart';
import 'package:news_app/breaking_news.dart';
import 'firebase_options.dart';
import 'model_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/trending_news.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SignIn());
  }
}



