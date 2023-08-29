import 'dart:io';

import 'package:blog_app/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'dart:convert';

import '../util/constants.dart';
import '../widget/blog_post_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = APIKeys.bllogerApiIKey;
  final String blogId = APIKeys.blogID;
  String nextPageToken = ''; //

  var _isLoading = true; //For progress bar
  var posts;
  var imgUrl;
  //initialization
  void initState() {
    CheckUserConnection();
    super.initState();
   // fetchData();
  }

  //Function to fetch data from JSON
  @override
  fetchData() async {
    print("attempting");
    final String url =
 //   posts?key=<api_key>&maxResults=30&nextPageToken=<nextPageToken here>
        "https://www.googleapis.com/blogger/v3/blogs/$blogId/posts/?key="
        "$apiKey&maxResults=25&nextPageToken=$nextPageToken";

    final response = await http.get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      //HTTP OK is 200
      final jsonData = json.decode(response.body);
      final Map items = json.decode(response.body);
      nextPageToken = jsonData['nextPageToken'] ?? "";


      var post = items['items'];
      setState(() {
        _isLoading = false;
      //  print(nextPageToken);
        print("mmj");
        this.posts = post;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Social Media Blog"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                fetchData();
              })
        ],
      ),
      drawer: Drawer_blog(desc:'ff'),
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: _isLoading
                    ? GestureDetector(
                      child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          new CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(child:
                            Text(T,
                            textAlign: TextAlign.center,
                              textScaleFactor: 1.5,
                            )),
                          )
                        ],
                      )),
                    )
                    : ListView.builder(

                        itemCount: this.posts != null ? this.posts.length : 0,
                        itemBuilder: (context, i) {
                          final Post = this.posts[i];
                          final postDesc = Post["content"];
                          //All the below code is to fetch the image
                          var document = parse(postDesc);
                          //Regular expression
                          RegExp regExp = new RegExp(
                            r"(https?:\/\/.*\.(?:png|jpg|))",
                            caseSensitive: false,
                            multiLine: false,
                          );
                          final match = regExp
                              .stringMatch(document.outerHtml.toString())
                              .toString();
                          //print(document.outerHtml);
                          //print(document.outerHtml);
                          //print("firstMatch : " + match);
                          //Converting the regex output to image (Slashing) , since the output from regex was not perfect for me
                          if (match.length > 5) {
                            if (match.contains(".png")) {
                              imgUrl =
                                  match.substring(0, match.indexOf(".png"));
                              //print(imgUrl);
                            } else if (match.contains(".jpg")) {
                              imgUrl =
                                  match.substring(0, match.indexOf(".jpg"));
                            } else {
                              imgUrl =
                                  "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFlQKvHKgpMqFXOrISpzrHMIbObF2iumQWufn3BzOkSV05bU0VxFTug285zBAPriJKorw_O5HiZauGifviH4KJiqtv_Znza_unj_Q1CyGb0eN_aLMj5cujOSTetTs066nR4IjBCam3PcsjK-4QwkB2tUwJfDX8h6O9qOTsDfXQhngQLCbeM-4pyzchxw/w640-h360/grow%20your%20business%20with%20your%20personal%20profile.png";
                            }
                          }
                          String description = document.body!.text.trim();
                          //print(description);

                          return Column(
                            children: [
                              new BlogPostCard(
                                title: Post["title"],
                                imageUrl: imgUrl,
                                desc: Post['content'],
                                //description: description.replaceAll("\n", ", "),
                              ),
                            ],
                          );

                        },
                      )),
          ),
          // Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: TextButton(onPressed: () {}, child: Text('load more'))),
        ],
      ),
    );
  }

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Connecting...";
          fetchData();
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Please Turn On You Data";
      });
    }
  }


// void fetchSecondData() async{
  //   //https://www.googleapis.com/blogger/v3/blogs/<blog_ID>/
  //   // posts?key=<api_key>&maxResults=30&nextPageToken=<nextPageToken here>
  //
  //   final String url =
  //       "https://www.googleapis.com/blogger/v3/blogs/$blogId/posts/?"
  //       "key=$apiKey&nextPageToken=CgkIChipjp-EgDAQp93BgO7ErKVCGAA";
  //   final params = {
  //     'key': apiKey,
  //     'maxResults': '10',
  //     'nextPageToken': nextPageToken,
  //   };
  //
  //   // final uri = Uri.parse(baseUrl).replace(queryParameters: params);
  //   //final response = await http.get(uri);
  //
  //   final response = await http.get(Uri.parse(url).replace(queryParameters: params));
  //   //print(response);
  //   if (response.statusCode == 200) {
  //     //HTTP OK is 200
  //     final Map items = json.decode(response.body);
  //     var post = items['items'];
  //     setState(() {
  //       nextPageToken = items['nextPageToken'] ?? ''; // Update nextPageToken
  //       _isLoading = false;
  //       print(nextPageToken);
  //       this.posts = post;
  //     });
  //   }
  // }
}
