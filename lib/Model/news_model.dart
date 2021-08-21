import 'package:intl/intl.dart';

class NewsModel{
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;


  var formatter1 = new DateFormat('yyyy-MM-ddddTHH:mm:ssZ');
    var formatter2 = new DateFormat('MM/dd/yyyy');


  NewsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    content = json['content'];
    publishedAt = json['publishedAt'];
    final DateTime d = formatter1.parse(publishedAt!);
    publishedAt = formatter2.format(d);
  }

}