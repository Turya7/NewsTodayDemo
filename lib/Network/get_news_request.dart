import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_today_demo/Model/news_model.dart';
import 'package:news_today_demo/Network/api_call.dart';
import 'package:news_today_demo/Network/get_news_request_param.dart';

class GetNewsRequest {

  ApiCall _apiCall =  ApiCall();
  late StreamController controller;
  StreamSink<dynamic> get getNewsSink => controller.sink;
  Stream<dynamic> get getNewsStream => controller.stream;

  GetNewsRequest(){
    controller = StreamController<dynamic>.broadcast();
  }

  getTopHeadlines(GetNewsRequestParam request) async {
    Response response = await (_apiCall.get(request.getParams()));
    print('Response code :'+response.body);
    List<NewsModel> listOfNews = [];
    if(response.statusCode == 200){
      Map mainObj = jsonDecode(response.body);
      if(mainObj["status"] == "ok"){
        dynamic articles = mainObj["articles"];
        for(int i = 0; i< articles.length; i++) {
          listOfNews.add(NewsModel.fromJson(articles[i]));
        }
      }
    }
    getNewsSink.add(listOfNews);
  }

}