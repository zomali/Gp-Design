import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/login_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'BlockNavigation.dart';
import 'Menu.dart';

class sidebar extends StatefulWidget {
  final student std;
  sidebar(this.std);
  @override
  State<sidebar> createState() => _sidebarState(std);
}

class _sidebarState extends State<sidebar>
    with SingleTickerProviderStateMixin<sidebar> {
  student std;
  _sidebarState(this.std);
  AnimationController? _animationController;
  StreamController<bool>? isSidebaropenstreamctrl;
  Stream<bool>? isSidebarstream;
  StreamSink<bool>? isSidebaropensink;
  //final bool isSidebarOpened = true ;
  final _animationDura = const Duration(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDura);
    isSidebaropenstreamctrl = PublishSubject<bool>();
    isSidebarstream = isSidebaropenstreamctrl!.stream;
    isSidebaropensink = isSidebaropenstreamctrl!.sink;
  }

  @override
  void dispose() {
    _animationController!.dispose();
    isSidebaropenstreamctrl!.close();
    isSidebaropensink!.close();
    super.dispose();
  }

  void oniconpress() {
    final animationstatus = _animationController!.status;
    final isAnimationCompleted = animationstatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSidebaropensink!.add(false);
      _animationController!.reverse();
    } else {
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
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDura,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  color: Colors.blue[900]!,
                  child: Column(
                    
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<Navigationn>(context)
                              .add(NavigationEvents.profile);
                          oniconpress();
                        },                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(std.profile_picture),
                              ),
                            ),
                            SizedBox(height: 16,),
                            Text(
                              std.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 6.0,),
                            Text(
                              std.email,
                             style: TextStyle(
                              color: Colors.white60,
                              fontSize: 15,),
                           ),
                          ],
                        ),                        
                        /*
                         child: ListTile(
                          
                          title: Text(
                            std.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            std.email,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 15,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(std.profile_picture),
                          ),
                        ),*/
                      ),//profile_pic
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<Navigationn>(context)
                              .add(NavigationEvents.HomePageClickedEvent);
                          oniconpress();
                        },
                        child: Menu_SideBar(
                          icon: Icons.home,
                          iconColor: Colors.cyan,
                          title: "Home",
                          titleColor: Colors.white,
                        ),
                      ),// Home_btn


                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<Navigationn>(context)
                              .add(NavigationEvents.analytics);
                          oniconpress();
                        },
                        child: Menu_SideBar(
                          icon: Icons.insert_chart_outlined_sharp,
                          iconColor: Colors.cyan,
                          title: "Analytics",
                          titleColor: Colors.white,
                        ),
                      ),//Analytics_btn
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<Navigationn>(context)
                              .add(NavigationEvents.profile);
                          oniconpress();
                        },
                        child: Menu_SideBar(
                          icon: Icons.person_rounded,
                          iconColor: Colors.cyan,
                          title: "Profile",
                          titleColor: Colors.white,
                        ),
                      ),//Profile_btn
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_screen()),
                          );
                        },
                        child: Menu_SideBar(
                          icon: Icons.logout,
                          iconColor: Colors.red[400],
                          title: "Log out",
                          titleColor: Colors.white,
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
                      color: Colors.blue[900]!,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController!.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
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
