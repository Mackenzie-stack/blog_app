import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'dart:convert';

class FakeHomePage extends StatefulWidget {
  @override
  _FakeHomePageState createState() => _FakeHomePageState();
}

class _FakeHomePageState extends State<FakeHomePage> {
  final String apiKey = 'AIzaSyC7ENUcXTLoTO6WpS5RZ0YJHnhEjTNSsQI';
  final String blogId = '4776826234817506983';
  String nextPageToken = ''; //

  var _isLoading = true; //For progress bar
  var posts;
  var imgUrl;
  //initialization
  void initState() {
    super.initState();
    _fetchData();
    print("mmmmmm");
  }

  //Function to fetch data from JSON
  @override
  Future<void> _fetchData() async {
    final params = {
      'key': apiKey,
      'maxResults': '5',
      'nextPageToken': nextPageToken,
    };
//    final response = await http.get(Uri.parse(url).replace(queryParameters: params));

    print("attempting");
    final String url =
    "https://www.googleapis.com/blogger/v3/blogs/$blogId/posts/?key=$apiKey";
    final response = await http.get(Uri.parse(url).replace(queryParameters: params));
    print(response);
    if (response.statusCode == 200) {
      //HTTP OK is 200
      final Map items = json.decode(response.body);
     // var pp = items['nextPageToken'];
      nextPageToken = items['nextPageToken'] ?? '';

      var post = items['items'];
      setState(() {
        nextPageToken = items['nextPageToken'] ?? ''; // Update nextPageToken
        _isLoading = false;
        print(nextPageToken);
        this.posts = post;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Savvy Digits"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              })
        ],
      ),
      body: Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : ListView.builder(
            itemCount: this.posts != null ? this.posts.length : 0,
            itemBuilder: (context, i) {
              final Post = this.posts[i];
              final postDesc = Post["content"];
              //All the below code is to fetch the image
              //print(description);

              return Column(
                children: [
                  new Card(
                    child: Text(Post["title"]),
                  )
                ],
              );

            },
          )),
    );
  }
}
