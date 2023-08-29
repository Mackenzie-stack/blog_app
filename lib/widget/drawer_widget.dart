import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/posts.dart';

class Drawer_blog extends StatelessWidget {
  final String appVersion = '1.0.0';

  final String desc;
  //final String description;

  Drawer_blog({required this.desc});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Social Media Blog',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Terms and Conditions'),
            onTap: () {
              // Navigate to terms and conditions page
              Navigator.pop(context);
              // Replace with your navigation logic
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              Navigator
                  .of(context)
                  .push(new MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return PostView(desc, 'jjj', 'kk');
                },
              ));
              // Replace with your navigation logic
            },
          ),
          ListTile(
            title: Text('Version: $appVersion'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}