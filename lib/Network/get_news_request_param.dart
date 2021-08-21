import 'package:news_today_demo/Utils/constants.dart';

class GetNewsRequestParam {

  String country = "in";
  String category = "";
  String getParams()  {
    String data = "country" +  Constants.EQUAL_SYMBOL + country + Constants.AMPERSAND_SYMBOL +
        "category" +  Constants.EQUAL_SYMBOL + category + Constants.AMPERSAND_SYMBOL +
        "apiKey" + Constants.EQUAL_SYMBOL + Constants.API_KEY ;
    return Constants.BASE_URL + Constants.TOP_HEADLINES + data;
  }
}