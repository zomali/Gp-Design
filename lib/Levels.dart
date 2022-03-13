import 'package:flutter/material.dart';
import 'L_types.dart';
import 'package:gp/myprofile_screen.dart';

import 'Home.dart';
import 'Types.dart';
//import 'package:flutter_application_1/home.dart';
//import 'package:flutter_application_1/types.dart';

class Levels extends StatelessWidget {
  final int ind;
  Levels(this.ind);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLevel(ind),
    );
  }
}
class HomeLevel extends StatefulWidget {
  int ind;
  HomeLevel(this.ind);

  @override
  _HomeLevelState createState() => _HomeLevelState();
}

class _HomeLevelState extends State<HomeLevel> {
  //int _selectedIndex = 1;
  List<String> levels=[];

  List<bool> know=[];

  addlevels(){
    if(widget.ind==1){
      levels.add("Level 1");
      know.add(true);
      for(int i=2;i<6;i++){
        levels.add("Level $i");
        know.add(false);
      }
    }else{
      for(int i=1;i<=widget.ind;i++){
        levels.add("Level $i");
        know.add(true);
      }
      for(int i=widget.ind+1;i<6;i++){
        levels.add("Level $i");
        know.add(false);
      }
    }
  }

  Widget? putIcon(index){
    if(know[index]==false){
      return const Icon(Icons.lock);
    }else{
      return null;
    }

  }
  // static  List<Widget> _pages = <Widget>[
  //   Home(0),
  //   Levels(1),
  //
  //
  //   types(),
  //   MyProfileScreen(),
  //
  //
  // ];
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //
  //
  //     //   print("index = ${widget.ind} ");
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context)=>moveToPage(index)));
  //
  //
  //
  //   },
  //   );
  // }
  // Widget moveToPage(int index){
  //   // if(index==0){
  //   //   return Home(widget.ind);
  //   // }else {
  //   //   return Levels(widget.ind);
  //   // }
  //   return _pages.elementAt(_selectedIndex);
  // }_selectedIndex

  @override
  Widget build(BuildContext context) {
    addlevels();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Colors.green)
              )
          )
      ),
      home: Scaffold(
          backgroundColor: Colors.blue[600],
          appBar: AppBar(
            title:const Text("Levels page"),
            leading:const Icon(Icons.read_more),
          ),

          body:
          ListView.builder(itemCount : levels.length,
            itemBuilder: (cxt,index){
              return Card(
                margin:const EdgeInsets.all(4),
                elevation: 8,
                child: ListTile(
                  trailing: putIcon(index),
                  enabled: know[index],
                  title:
                  Text(levels[index],
                    style:const TextStyle(
                        fontSize: 22,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400
                    ),),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> Types(index+1,know)));
                  },
                ),
              );
            },
          )
      ),
    );
  }
}
