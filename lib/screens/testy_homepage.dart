import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../util/constants.dart';

class BlogPost {
  final String title;
  final String content;

  BlogPost({required this.title, required this.content});
}

class BlogPostList extends StatefulWidget {
  @override
  _BlogPostListState createState() => _BlogPostListState();
}

class _BlogPostListState extends State<BlogPostList> {
  final String apiKey = APIKeys.bllogerApiIKey;
  final String blogId = APIKeys.blogID;

  String _nextPageToken ='' ;
  String get getnextPageToken => _nextPageToken;

   setnextPageToken(String value) {
    _nextPageToken = value;
  }

  List<BlogPost> posts = [];

  Future<void> fetchPosts() async {
    final baseUrl=  'https://www.googleapis.com/blogger/v3/blogs/'
        '$blogId/posts?key=$apiKey'
        '//&maxResults=10&'
        'nextPageToken=CgkIChipjp-EgDAQp93BgO7ErKVCGAA';

    final params = {
      'key': apiKey,
      //'maxResults': '10',
      'nextPageToken': getnextPageToken,
    };


    final uri = Uri.parse(baseUrl).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final items = jsonData['items'] as List;
      String pt = jsonData['nextPageToken'] ?? "";
      setnextPageToken(pt);

      setState(() {
      print(getnextPageToken);
        posts.addAll(items.map((item) => BlogPost(
        title: item['title'],
        content: item['content'],)));});
    } else {
      throw Exception('Failed to load posts');
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
                  //_isLoading = true;
                });
                fetchPosts();
              })
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length + 1, // Add 1 for the load more button
        itemBuilder: (context, index) {
          if (index < posts.length) {
            return ListTile(
              title: Text(posts[index].title),
            );
          } else if (getnextPageToken.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: fetchPosts,
                child: Text('Load More'),
              ),
            );
          } else {
            return Center(
              child:  ElevatedButton(
                onPressed: fetchPosts,
                child: Text('Load More'),
              ),
            );
          }
        },
      ),
    );
  }
}
