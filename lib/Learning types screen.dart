import 'package:flutter/material.dart';
import 'package:gp/Home.dart';
import 'package:gp/Levels.dart';
import 'package:gp/myprofile_screen.dart';

class types extends StatefulWidget {
  int _selectedIndex = 3;
  static  List<Widget> _pages = <Widget>[
    Home(0),
    Levels(1),


    types(),
    MyProfileScreen(),

  ];

  @override
  _typesState createState() => _typesState();
}

class _typesState extends State<types> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;


      //   print("index = ${widget.ind} ");
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>moveToPage(index)));



    },
    );
  }

  Widget moveToPage(int index){

    return types._pages.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,

        selectedItemColor: Colors.blue,
        selectedFontSize:16.5 ,


        unselectedItemColor: Colors.grey ,
        unselectedFontSize: 11,
        //    currentIndex: 0,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
         //   backgroundColor: Colors.blue,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            //  icon: Icon(Icons.up),
            label: 'Levels',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.merge_type),
              label: 'Types',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',

          )
        ],
        // onTap: (index){
        //   print("index = ${widget.ind} ");
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context)=>moveToPage(index)));
        //
        //
        //
        // },
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,

      ),
      body: SingleChildScrollView(
          child: Container(
            color: Colors.blue[200],
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => {print("'Clicked'")},
                  child: Container(
                    width: 250,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://buffer.com/resources/content/images/resources/wp-content/uploads/2017/02/video-stats@2x.png',
                          ),
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(.7),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'VIDEO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                GestureDetector(
                  onTap: () => {print("'Clicked'")},
                  child: Container(
                    padding: EdgeInsets.only(top: 30.0),
                    width: 250,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Text-txt.svg/822px-Text-txt.svg.png',
                          ),
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(.7),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'TEXT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //////////////////////////////////////////////////////////////////////
                GestureDetector(
                  onTap: () => {print("'Clicked'")},
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    width: 250,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjXppM2woENC9HihQvYLMSWZ0r9vzaNEnjkj_moLa2kKQJKSG0a0oaQsQu1TUoESSF_XM&usqp=CAU',
                          ),
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(.7),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'AUDIO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///////////////////////////////////////////////////////
                GestureDetector(
                  onTap: () => {print("'Clicked'")},
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    width: 250,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX48JYpPPow8zQXp34oKHyqRbECSs1dUpOdw&usqp=CAU',
                          ),
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(.7),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'IMAGE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}