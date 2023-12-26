import 'package:flutter/material.dart';
import 'package:news_app/reading_page.dart';
import 'package:news_app/reading_web.dart';
import 'model_data.dart';
import 'breaking_news.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model_data.dart';

class TrendingNews extends StatefulWidget {
  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  //calling api
  late Future<ModelData> apiData;

  @override
  void initState() {
    // TODO: implement initState
    apiData = getData();
  }

  // calling api method
  Future<ModelData> getData() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7a2f423f24e8431ca449087f3970be5a'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ModelData.fromJson(data);
    } else {
      return throw Exception('Loading data...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiData,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                  itemCount: 20,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var pre = snapshot.data!.articles![index];
                    return
                      pre.urlToImage!= null &&
                          pre.toString() != "file:///null" &&
                          pre.title != null &&
                          pre.description != null &&
                          pre.source!= null &&
                          pre.publishedAt !=null &&
                          pre.content !=null &&
                    pre.url !=null
                        ?
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 7, ),
                        child: Material(
                          elevation: 1.5,
                          borderRadius:  BorderRadius.all(Radius.circular(15),),

                          // body container
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ReadingWeb(url: pre.url!),));

                              /*
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  ReadingPage(imageUrl: pre.urlToImage, title: pre.title, description: pre.description,
                                      sourceId: pre.publishedAt , pubDate: pre.publishedAt , content: pre.content),
                              ),
                              );*/
                            },
                            child: Container(
                              height: 130,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      //image
                                      child: Image.network(
                                        snapshot.data!.articles![index].urlToImage.toString(),
                                        width: 110,
                                        alignment: Alignment.center,
                                        height:
                                        MediaQuery.of(context).size.height,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, right: 7, top: 9, bottom: 3),
                                      child: Column(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Color(0xFF3C4046)
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              snapshot.data!.articles![index].description.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ) : Container();
                  }),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
