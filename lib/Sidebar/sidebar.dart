import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/login_screen.dart';
import 'package:gp/pages/Info.dart';
import 'package:rxdart/rxdart.dart';

import 'BlockNavigation.dart';
import 'Menu.dart';
class sidebar extends StatefulWidget {


  @override
  State<sidebar> createState() => _sidebarState();
}

class _sidebarState extends State<sidebar> with SingleTickerProviderStateMixin<sidebar>{
  AnimationController? _animationController;
   StreamController<bool>? isSidebaropenstreamctrl;
   Stream<bool>? isSidebarstream;
   StreamSink<bool> ? isSidebaropensink;
  //final bool isSidebarOpened = true ;
  final _animationDura = const Duration(milliseconds: 500);
  @override
  void initState() {
    super.initState();
        _animationController = AnimationController(vsync: this, duration: _animationDura);
        isSidebaropenstreamctrl = PublishSubject<bool>();
        isSidebarstream =isSidebaropenstreamctrl!.stream;
        isSidebaropensink = isSidebaropenstreamctrl!.sink;
  }
  @override
  void dispose() {
    _animationController!.dispose();
    isSidebaropenstreamctrl!.close();
    isSidebaropensink!.close();
    super.dispose();
  }
  void oniconpress(){
    final animationstatus = _animationController!.status;
    final isAnimationCompleted = animationstatus == AnimationStatus.completed;
    if(isAnimationCompleted)
      {
        isSidebaropensink!.add(false);
        _animationController!.reverse();
      }
    else{
      isSidebaropensink!.add(true);
      _animationController!.forward();
    }
  }
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;


    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarstream,
      builder: (context,isSideBarOpenedAsync){
        return AnimatedPositioned(
          duration: _animationDura ,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0: -screenWidth,
          right: isSideBarOpenedAsync.data! ?  0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF262AAA),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: (){
                                    // navigate to profile
                        },
                        child: ListTile(
                          title: Text(
                            "Hossam",
                            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            "hh@gmail.com",
                            style: TextStyle(
                              color: Color(0xFF1BB5FD),
                              fontSize: 18,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.white,
                            ),
                            radius: 40,
                          ),

                        ),
                      ),

                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      GestureDetector(
                        onTap: (){
                          BlocProvider.of<Navigationn>(context).add(NavigationEvents.HomePageClickedEvent);
                          oniconpress();
                        },
                        child: Menu_SideBar(
                          icon: Icons.home,
                          title: "Home",
                          // ontap: () {
                          //
                          //  BlocProvider.of<Navigationn>(context).add(NavigationEvents.HomePageClickedEvent);
                          // },
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          BlocProvider.of<Navigationn>(context).add(NavigationEvents.evalution);
                          oniconpress();
                        },
                        child: Menu_SideBar(
                          icon: Icons.person,
                          title: "My Quizes",
                          // ontap: () {
                          //
                          //   BlocProvider.of<Navigationn>(context).add(NavigationEvents.evalution);
                          // },
                        ),
                      ),

                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),

                      GestureDetector(
                        onTap: (){
                          BlocProvider.of<Navigationn>(context).add(NavigationEvents.Infoevent);
                          oniconpress();
                          },
                        child: Menu_SideBar(
                          icon: Icons.info,
                          title: "INfo",
                          // ontap: (){
                          //   BlocProvider.of<Navigationn>(context).add(NavigationEvents.HomePageClickedEvent);
                          //
                          // },
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Login_screen()),
                          );
                        },
                        child: Menu_SideBar(
                          icon: Icons.logout,
                          title: "Log out",
                          // ontap: (){
                          //   BlocProvider.of<Navigationn>(context).add(NavigationEvents.evalution);
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.1),
                child: GestureDetector(
                  onTap: () {
                    oniconpress();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 40,
                      height: 100,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController!.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
