import 'package:flutter/material.dart';

class Favourite extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(title: Center(child: Text("Favourite")), flexibleSpace: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF3366FF),
                const Color(0xFF00CCFF),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),),
      body: Container(
        child: Center(
          child: Text("Favourite Page"),
        ),
      ),
    );
  }

}