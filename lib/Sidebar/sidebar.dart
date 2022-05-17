import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/login_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'BlockNavigation.dart';
import 'Menu.dart';

class sidebar extends StatefulWidget {
  // final student std;
  // sidebar(this.std);
  @override
  State<sidebar> createState() => _sidebarState();
}

class _sidebarState extends State<sidebar>
    with SingleTickerProviderStateMixin<sidebar> {
  // student std;
  // _sidebarState(this.std);
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
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          // navigate to profile
                        },
                        child: ListTile(
                          title: Text(
                            "Ahmed Gamal",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            "Ahmed2018170000@cis.asu.edu.eg",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 15,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage('https://1.bp.blogspot.com/-cJ0t9sZe2eE/Xd-pc7mH88I/AAAAAAAAAZM/giDxYSf5CBoA3zLmYW4yHnKPcQUxnWeRwCLcBGAsYHQ/s1600/%25D8%25AA%25D9%2585%25D8%25A8%2B%25D8%25AC%25D9%258A%25D8%25B1%25D9%2589%2B%25D8%25A8%25D9%258A%25D8%25B6%25D8%25AD%25D9%2583%2B%25D9%2588%25D8%25AD%25D8%25A7%25D8%25B7%25D8%25B7%2B%25D8%25A7%25D9%258A%25D8%25AF%25D9%2587%2B%25D8%25B9%25D9%2584%25D9%2589%2B%25D8%25A8%25D9%2582%25D9%2587.jpg'),
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
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<Navigationn>(context)
                              .add(NavigationEvents.profile);
                          oniconpress();
                        },
                        child: Menu_SideBar(
                          icon: Icons.person,
                          iconColor: Colors.cyan,
                          title: "Profile",
                          titleColor: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<Navigationn>(context)
                              .add(NavigationEvents.dashboard);
                          oniconpress();
                        },
                        child: Menu_SideBar(
                          icon: Icons.dashboard,
                          iconColor: Colors.cyan,
                          title: "Dashboard",
                          titleColor: Colors.white,
                        ),
                      ),
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
                      ),
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
