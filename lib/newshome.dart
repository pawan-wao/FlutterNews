import 'package:flutter/material.dart';
import 'package:news_app/trending_news.dart';

import 'breaking_news.dart';

class NewsHome extends StatelessWidget{
  String user_name;
  NewsHome({ this.user_name ="Mr.X"});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFFF9F8FD),
          body:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // app name
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Flutter',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                      Text('News',style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold,fontSize: 25),)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                // greetings
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text('Good Morning!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(user_name.toString().trim(),style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                BreakingNews(),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Text(
                        'Trending News',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C4046),
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text('Read More',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.lightBlueAccent)),
                    ],
                  ),
                ),
                TrendingNews(),
              ],
            ),
          )
      ),
    );
  }
}