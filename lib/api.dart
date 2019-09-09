import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/video.dart';

const API_KEY = "AIzaSyA_jxFpcdoBoKCSQOMbqPZk0UIq0KQQNfk";

//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"

//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"

//"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"



class API {

  search(String search) async{

    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );

    decode(response);

  }

 List<Video> decode(http.Response response) {
    if(response.statusCode == 200) {
      var decoded = json.decode(response.body);


      List<Video> videos = decoded["items"].map<Video>(
          (map){
            return Video.fromJson(map);
          }
      ).toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }

}