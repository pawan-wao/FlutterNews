/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'breaking_news.dart';
import 'trending_news.dart';
import 'model_data.dart';
import 'main.dart';
import 'package:readmore/readmore.dart';
class ReadingPage extends StatelessWidget {

  String? imageUrl;
  String? title;
  String? description;
  String? sourceId ;
  String? pubDate;
  String? content;

  ReadingPage(
      {required this.imageUrl, required this.title, required this.description,
        required this.sourceId, required this.pubDate, required this.content
      });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          //main image
          Image.network(imageUrl.toString(),
            height:MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),

          //back arrow
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 50),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp(),));
              },
              child: Icon(CupertinoIcons.back,color: Colors.white,
              size: 33,
              ),
            ),
          ),

          // News title
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 255),
            child: Column(
              children: [
              Flexible(
                child: Text(title.toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
            ),
          ),
          // white container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      // author, readinTime, views
                      Row(
                        children: [
                          Icon(Icons.person,color: Colors.grey,),
                          SizedBox(width: 5,),
                          Text(sourceId.toString()),
                          Spacer(),
                          Icon(CupertinoIcons.clock,color: Colors.lightBlue,),
                          SizedBox(width: 5,),
                          Text('15 min'),
                          SizedBox(width: 20,),
                          Icon(CupertinoIcons.eye, color: Colors.lightBlue,),
                          SizedBox(width: 5,),
                          Text('456'),
                        ],
                      ),
                      SizedBox(height: 20,),
                      // title
                     ReadMoreText(title.toString(),
                    trimExpandedText: 'Read more',
                    trimCollapsedText: 'Show less',
                    trimLines: 2,
                    moreStyle: TextStyle(fontWeight: FontWeight.bold,
                   fontSize: 23,
                    ),
                     ),
                      SizedBox(height: 15,),
                      ReadMoreText(content.toString(),
                        trimExpandedText: 'Read more',
                        trimCollapsedText: 'Show less',
                        trimLines: 100,
                        moreStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}*/