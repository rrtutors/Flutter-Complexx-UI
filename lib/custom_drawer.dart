import 'package:flutter/material.dart';
import 'package:flutter_complex_ui/favourites.dart';
import 'package:flutter_complex_ui/settings.dart';
import 'dart:math' as math;
import 'home.dart';

class CustomDrawer extends StatefulWidget{
  static CustomDrawerState of(BuildContext context) =>
      context.findAncestorStateOfType<CustomDrawerState>();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomDrawerState();
  }

}
typedef menuCallback = void Function(int pos);
class CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin
{
  AnimationController animationController;
  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  bool _canBeDragged;
  int position=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 225));
  }
  void toogle()
  {
    animationController.isDismissed?animationController.forward():animationController.reverse();
  }
  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {
        if (animationController.isCompleted) {
          close();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        onTap: animationController.isCompleted ?close () : null,
        child: AnimatedBuilder(
          animation: animationController,
          child: (position==0)?MyHomePage():Settings(),
          builder: (context,_){
            double animValue = animationController.value;
            final slideAmount = maxSlide * animValue;
            final contentScale = 1.0 - (0.3 * animValue);

            return Stack(
              children: [
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(onMenuSelect:(pos){
                      animationController.reverse();

                      setState(() {

                        position=pos;
                      });
                    }),
                  ),
                ),

                Transform.translate(
                  offset: Offset(maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: getWidget(),
                  ),
                ),
                Positioned(
                  top: 4.0 + MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: toogle,
                    color: Colors.white,
                    ),
                  ),
                ),



              ],
            );
          },
        ),
      ),
    );


  }
  getWidget()
  {
    if(position==0)return MyHomePage();
    else if(position==1)return Favourite();
    else return Settings();
  }


  open()=>animationController.forward();
  close()=>animationController.reverse();

  void setPosition(pos){
    setState(() {
      position=pos;
    });
  }

    void _onDragStart(DragStartDetails dragStartDetails)
    {
      bool isDragOpenFromLeft=animationController.isDismissed&&dragStartDetails.globalPosition.dx<minDragStartEdge;
      bool isDragCloseFromRight=animationController.isCompleted&&dragStartDetails.globalPosition.dx>maxDragStartEdge;
      _canBeDragged=isDragOpenFromLeft||isDragCloseFromRight;
    }

    void _onDragUpdate(DragUpdateDetails dragStartDetails)
    {
      if(_canBeDragged)
      {
        double delta=dragStartDetails.primaryDelta/maxSlide;
        animationController.value+=delta;
      }
    }
    void _onDragEnd(DragEndDetails details) {
      //I have no idea what it means, copied from Drawer
      double _kMinFlingVelocity = 365.0;

      if (animationController.isDismissed || animationController.isCompleted) {
        return;
      }
      if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
        double visualVelocity = details.velocity.pixelsPerSecond.dx /
            MediaQuery.of(context).size.width;

        animationController.fling(velocity: visualVelocity);
      } else if (animationController.value < 0.5) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    }
    @override
    void dispose() {
      animationController.dispose();
      super.dispose();
    }
  }





class MyDrawer extends StatelessWidget {
  const MyDrawer({this.onMenuSelect});

  final menuCallback onMenuSelect;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child:  AppBar(title: Text("Menu"), ),
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
              )
             ,
              /* Image.asset(
                'assets/flutter_europe_white.png',
                width: 200,
              ),*/
              ListTile(
                leading: Icon(Icons.new_releases),
                onTap: (){
                  onMenuSelect(0);
                },
                title: Text('News'),
              ),
              ListTile(
                leading: Icon(Icons.star),
                onTap: (){
                  onMenuSelect(1);
                },
                title: Text('Favourites'),
              ),
              ListTile(
                leading: Icon(Icons.map),
                onTap: (){
                  onMenuSelect(2);
                },
                title: Text('Map'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                onTap: (){
                  onMenuSelect(3);
                },
                title: Text('Settings'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                onTap: (){
                  onMenuSelect(4);
                },
                title: Text('Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}