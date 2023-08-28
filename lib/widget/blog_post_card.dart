import 'package:flutter/material.dart';

import '../models/posts.dart';

class BlogPostCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String desc;
  //final String description;

  BlogPostCard({required this.title, required this.imageUrl, required this.desc
    //required this.description
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
Text("Mackie"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 40),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,15,0),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                //check if the image is not null (length > 5) only then check imgUrl else display default img
                                image: new NetworkImage(imageUrl.toString().length >10
                                    ? imageUrl.toString()
                                    : "https://blogger.googleusercontent.com/img/b/R29vZ2xl/"
                                    "AVvXsEgFlQKvHKgpMqFXOrISpzrHMIbObF2iumQWufn3BzOkSV05bU0VxFTug285zBAPriJKorw_O"
                                    "5HiZauGifviH4KJiqtv_Znza_unj_Q1CyGb0eN_aLMj5cujOSTetTs066nR4IjBCam3PcsjK-"
                                    "4QwkB2tUwJfDX8h6O9qOTsDfXQhngQLCbeM-4pyzchxw/w640-h360/grow%20your%20business"
                                    "%20with%20your%20personal%20profile.png")),
                          ),
                        ),
                      ),
                    ],

                  ),


                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){ Navigator
                      .of(context)
                      .push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return PostView(title, imageUrl, desc);
                    },
                  ));
      }
    );
  }
}

