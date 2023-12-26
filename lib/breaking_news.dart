import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/reading_web.dart';
import 'main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'reading_page.dart';

class BreakingNews extends StatefulWidget {
  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

class _BreakingNewsState extends State<BreakingNews> {
  //calling api
  late Future<ModelData> apiData;

  @override
  void initState() {
    super.initState();
    apiData = getData();
  }

  Future<ModelData> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=2023-11-26&sortBy=publishedAt&apiKey=7a2f423f24e8431ca449087f3970be5a'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return ModelData.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var indexi = 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          //tittle and subtittle
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 20),
            child: Row(
              children: [
                Text(
                  'Breaking News',
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
          //carousel Slider, future builder
          FutureBuilder(
              future: apiData,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError) {
                  //creating breaking news section
                  return CarouselSlider.builder(
                    itemCount: snapshot.data!.articles!.length,
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      enlargeCenterPage: true,
                      height: 250,
                    ),
                    itemBuilder: (context, index, realindex) {
                      @override
                      void initState() {
                        indexi = realindex;
                      }

                      var pre = snapshot.data!.articles![index];
                      return pre.urlToImage != null &&
                              pre.toString() != "file:///null" &&
                              pre.title != null &&
                              pre.description != null &&
                              pre.source != null &&
                              pre.publishedAt != null &&
                              pre.content != null &&
                              pre.url != null
                          ?
                          //returning empty container if data is null
                          Stack(
                              children: [
                                //image container
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(17),
                                    ),
                                  ),
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                //image
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: snapshot.data!.articles![index]
                                                .urlToImage
                                                .toString() ==
                                            null
                                        ? Container()
                                        : InkWell(
                                            child: Image.network(
                                              snapshot.data!.articles![index]
                                                  .urlToImage
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReadingWeb(url: pre.url!,
                                                        ),
                                                  ));
                                              /*Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                ReadingPage(imageUrl: pre.urlToImage, title: pre.title, description: pre.description,
                                                    sourceId: pre.publishedAt, pubDate: pre.publishedAt , content: pre.content),
                                            ),
                                            );*/
                                            },
                                          ),
                                  ),
                                ),
                                //black screen for title
                                Align(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 1, right: 1, bottom: 0.2),
                                    child: Container(
                                      height: 75,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black45,
                                            Colors.black,
                                          ],
                                          begin: Alignment.centerRight,
                                          end: Alignment.topLeft,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            topLeft: Radius.circular(7),
                                            topRight: Radius.circular(7)),
                                      ),

                                      //tittle of breaking news
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.bottomLeft,
                                )
                              ],
                            )
                          : Container();
                      //return body if data is not null
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          SizedBox(
            height: 15,
          ),
          AnimatedSmoothIndicator(
            activeIndex: indexi,
            count: 5,
            axisDirection: Axis.horizontal,
            effect: ExpandingDotsEffect(),
          )
        ],
      ),
    );
  }
}
