import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
   runApp(
    const Home(),
  );
}
 class Home extends StatelessWidget {
   const Home({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: HomePage(),

     );
   }
 }
