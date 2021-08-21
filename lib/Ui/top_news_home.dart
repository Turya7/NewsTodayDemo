import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_today_demo/Model/news_model.dart';
import 'package:news_today_demo/Network/get_news_request.dart';
import 'package:news_today_demo/Network/get_news_request_param.dart';
import 'package:news_today_demo/Ui/details.dart';
import 'package:news_today_demo/Utils/color.dart';

class NewsTodayHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateOfNewsTodayHome();
  }
}

class StateOfNewsTodayHome extends State<NewsTodayHome> {

 late GetNewsRequest call ;
 late GetNewsRequestParam request;
 List<NewsModel> listOfNews = [];
 final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
 new GlobalKey<RefreshIndicatorState>();
  List<String> categories = ["business","entertainment","general","health","science","sports","technology"];

  @override
  void initState() {
    super.initState();
    call = GetNewsRequest();
    request = GetNewsRequestParam();
    request.category = categories.elementAt(Random().nextInt(6));
    call.getTopHeadlines(request);
    call.getNewsStream.listen((event) {
      listOfNews = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Container(
          padding: EdgeInsets.all(4.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [gradientStartColor, gradientEndColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 0.9])),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [Text(
                      'Top Headlines',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 30,
                        color: titleTextColor,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    ],
                  ),
                ),
                Divider(color: primaryTextColor,),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    itemCount: listOfNews.length,
                      itemBuilder: (context,i){
                        return Container(
                            padding: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, a, b) => DetailPage(newsInfo: listOfNews.elementAt(i),position: i),
                                  ),
                                );
                              },
                              child: Card(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 4,
                                                child: Container(
                                                  margin: EdgeInsets.all(8.0),
                                                  child: AspectRatio(
                                                    aspectRatio: 2,
                                                    child: Hero(
                                                      tag: i,
                                                      child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: listOfNews.elementAt(i).urlToImage??"",
                                                        errorWidget: (context, url, error){
                                                            return Icon(Icons.error);
                                                        },
                                                          ),
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 6,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 4.0),
                                                      child: Text(
                                                        "${listOfNews.elementAt(i).title}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 16.0,bottom: 8.0,right: 4.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${listOfNews.elementAt(i).publishedAt}",
                                                            overflow: TextOverflow.clip,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: contentTextColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${listOfNews.elementAt(i).author == null ? "--" : listOfNews.elementAt(i).author}",
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              color: navigationColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ));
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

 Future<void> _refresh() async {
   listOfNews.clear();
   setState(() {});
   call = GetNewsRequest();
   request = GetNewsRequestParam();
   request.category = categories.elementAt(Random().nextInt(6));
   call.getTopHeadlines(request);
   call.getNewsStream.listen((event) {
     listOfNews = event;
     setState(() {});
   });
 }

}
