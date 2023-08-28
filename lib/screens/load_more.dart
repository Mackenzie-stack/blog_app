import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogPost {
  final String title;
  final String content;

  BlogPost({required this.title, required this.content});
}

class BloggerAPIPage extends StatefulWidget {
  @override
  _BloggerAPIPageState createState() => _BloggerAPIPageState();
}

class _BloggerAPIPageState extends State<BloggerAPIPage> {
  String _nextPageToken = ""; // Initialize with an empty string or the appropriate token
  List<BlogPost> _blogPosts = [];
  bool _isLoading = false;

  Future<void> _fetchBlogPosts() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    final apiKey = 'AIzaSyC7ENUcXTLoTO6WpS5RZ0YJHnhEjTNSsQI'; // Replace with your actual API key
    final blogId = '4776826234817506983'; // Replace with your actual Blog ID
    final url = 'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';

    Map<String, String> params = {
      'key': apiKey,
      'nextpageToken': _nextPageToken,
    };

    Uri uri = Uri.parse(url).replace(queryParameters: params);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? "";

      List<BlogPost> newPosts = (data['items'] as List)
          .map((item) => BlogPost(
        title: item['title'],
        content: item['content'],
      ))
          .toList();

      setState(() {
        _nextPageToken = data['nextPageToken'] ?? "";
        _blogPosts.addAll(newPosts);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
      ),
      body: ListView.builder(
        itemCount: _blogPosts.length + 1,
        itemBuilder: (context, index) {
          if (index < _blogPosts.length) {
            return ListTile(
              title: Text(_blogPosts[index].title),
              //subtitle: Text(_blogPosts[index].content),
            );
          } else if (_nextPageToken.isEmpty) {
            return Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _fetchBlogPosts,
                child: Text('Load More'),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
