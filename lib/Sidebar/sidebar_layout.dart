import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/pages/Info.dart';
import 'package:gp/pages/hom.dart';
import 'package:gp/login_screen.dart';
import '';
import 'BlockNavigation.dart';
import 'SideBar.dart';
class side_layout  extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: BlocProvider<Navigationn>(
         create: (context) => Navigationn(hhh()),
         child: Stack(
           children: <Widget>[
             BlocBuilder<Navigationn, NavigationStates>(
               builder: (context, navigationState) {
                 return navigationState as Widget;
               },
             ),
            sidebar(),
          ],
        ),
      ),
    );
  }
}
