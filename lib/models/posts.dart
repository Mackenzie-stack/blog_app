import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostView extends StatelessWidget {
  var  title,
      //image,
      desc;

  PostView(String title, String image, String desc) {
    this.title = title;
   // this.image = image;
    this.desc = desc;
  }
  @override
  Widget build(BuildContext context) {
    if (desc.toString().contains("\n\n\n\n")) {
      desc = desc.toString().replaceAll("\n\n\n\n", "\n\n");
    }

    if (desc.toString().contains("\n\n\n")) {
      desc = desc.toString().replaceAll("\n\n\n", "\n");
    }
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Social media Blog"),
      ),
      body: new Container(
          child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: new Text(
                      title,
                      style: new TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // new Padding(
                  //   padding:
                  //   const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  //   child: new Container(
                  //     width: 500.0,
                  //     height: 180.0,
                  //     decoration: new BoxDecoration(
                  //       shape: BoxShape.rectangle,
                  //       image: new DecorationImage(
                  //           fit: BoxFit.fill,
                  //           //check if the image is not null (length > 5) only then check imgUrl else display default img
                  //           image: new NetworkImage(image.toString().length > 10
                  //               ? image.toString()
                  //               :"https://blogger.googleusercontent.com/img/b/R29vZ2xl/"
                  //               "AVvXsEgFlQKvHKgpMqFXOrISpzrHMIbObF2iumQWufn3BzOkSV05bU0"
                  //               "VxFTug285zBAPriJKorw_O5HiZauGifviH4KJiqtv_Znza_unj_Q1CyGb0eN_"
                  //               "aLMj5cujOSTetTs066nR4IjBCam3PcsjK-4QwkB2tUwJfDX8h6O9qOTsDfXQhngQLCbeM-"
                  //               "4pyzchxw/w640-h360/grow%20your%20business%20with%20your%20persona"
                  //               "l%20profile.png")),
                  //     ),
                  //   ),
                  // ),
                  new Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Html(
                      data: desc,

                    )
                    // Text(
                    //   desc,
                    //   style: new TextStyle(
                    //     fontSize: 18.0,
                    //   ),
                    // ),
                  ),
                ],
              ))),
    );
  }
}