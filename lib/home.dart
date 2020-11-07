import 'package:flutter/material.dart';

import 'custom_drawer.dart';
class MyHomePage extends StatefulWidget {


  MyHomePage({Key key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List listNews=[];
bool hasPages=true;
ScrollController _scrollController = new ScrollController();
int page=1;
@override
void initState() {

  super.initState();

}
@override
Widget build(BuildContext context) {
  // TODO: implement build
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(title: Center(child: Text("News",)), flexibleSpace: Container(
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
    body: ListView(
      children: [
        getMars(Colors.grey),
        getMars(Colors.red),
        getMars(Colors.yellow),
        getMars(Colors.white70),
      ],
    )
  );
}

getMars(color)
{
  return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          planetCard(color),
          planetThumbnail,
        ],
      )
  );
}
  final planetThumbnail = new Container(
    margin: new EdgeInsets.symmetric(
        vertical: 16.0
    ),
    alignment: FractionalOffset.centerLeft,
    child:    CircleImage(size:  Size.fromWidth(120),child: Image.network("https://p1.pxfuel.com/preview/366/297/294/model-jewelry-lady-young-indian-girl-royalty-free-thumbnail.jpg",
      width: 100,
      height: 120,
      fit: BoxFit.fitWidth,
    ),),
  );

   planetCard(color) {
     return Container(
       height: 124.0,
       margin: EdgeInsets.only(left: 46.0),
       decoration: BoxDecoration(
         color: (color),
         shape: BoxShape.rectangle,
         borderRadius: BorderRadius.circular(8.0),
         boxShadow: <BoxShadow>[
           BoxShadow(
             color: Colors.black12,
             blurRadius: 10.0,
             offset: Offset(0.0, 10.0),
           ),
         ],
       ),
     );
   }

}

class CircleImage extends StatelessWidget{

  final Size size;
  final Widget child;

  CircleImage({Key key,@required this.child,this.size=const Size.fromWidth(120)}):super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      decoration: new BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle),
      height: size.width,
      child: ClipOval(
        child: child,

      ),
    );
  }


}