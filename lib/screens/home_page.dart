import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = 'AIzaSyC7ENUcXTLoTO6WpS5RZ0YJHnhEjTNSsQI';
  final String blogId = '4776826234817506983';

  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    fetchBlogPosts();
  }

  Future<void> fetchBlogPosts() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey'));

    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body)['items'];
      });
    } else {
      print('Failed to fetch blog posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var imageUrl = posts[index]['author']['image']['url']; // Assuming images are stored in the 'images' array
print(posts[index]['author']);
          return
            ListTile(
             // leading: Image.network(imageUrl),
            title: Text(posts[index]['title']),
            trailing: Text(posts[index]['author']['displayName']),
          );
        },
      ),
    );
  }
}















// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:blog_app/models//api_key.dart' as Constant;
// import '../models/blog_all.dart';
// import '../models/blog_items.dart';
//
//
//
// Future<PostList> fetchPosts() async {
//   var postListUrl = Uri.https(
//       "blogger.googleapis.com", "/v3/blogs/4776826234817506983/posts/", {"key": 'AIzaSyC7ENUcXTLoTO6WpS5RZ0YJHnhEjTNSsQI'});
//   final response = await http.get(postListUrl);
//   if (response.statusCode == 200) {
//     return PostList.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception();
//   }
// }
//
//
// Future<PostList> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://www.googleapis.com/blogger/v3/blogs/4776826234817506983?key'
//       '=AIzaSyC7ENUcXTLoTO6WpS5RZ0YJHnhEjTNSsQI'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     print("Successful");
//     return PostList.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   late Future<PostList> futureAlbum;
//
//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Blog'),
//       ),
//       body: FutureBuilder(
//         // : null,
//           future: fetchPosts(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: snapshot.data!.posts.length ?? 1,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(
//                         snapshot.data .posts[index].title ?? "no items",
//                       ),
//                       subtitle: Text(
//                           snapshot.data.posts[index].author.displayName ??
//                               "No Auther"),
//                     ),
//                   );
//                 },
//               );
//           }),
//     );
//
//     );
//   }
// }
