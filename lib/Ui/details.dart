import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_today_demo/Model/news_model.dart';
import 'package:news_today_demo/Utils/color.dart';


class DetailPage extends StatelessWidget {
  final NewsModel newsInfo;
  final int position;

  const DetailPage({required this.newsInfo,required this.position});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 300),
                        Text(
                          newsInfo.title ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 25,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 32),
                        Divider(color: Colors.black38),
                        Text(
                          newsInfo.content ?? '',
                          maxLines: 50,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 18,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 32),
                        Divider(color: Colors.black38),
                        Text(
                          newsInfo.url ?? '',
                          maxLines: 50,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 18,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              right: 0,
              child: Hero(
                  tag: position,
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width/1.5,
                      height: MediaQuery.of(context).size.height/3,
                      imageUrl: newsInfo.urlToImage??"",
                      errorWidget: (context, url, error){
                        return Icon(Icons.error);
                      },
                    ),
                  ),)
            ),
            Positioned(
              top: 50,
              left: 5,
              child: Text(
                position.toString(),
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 100,
                  color: primaryTextColor.withOpacity(0.08),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
