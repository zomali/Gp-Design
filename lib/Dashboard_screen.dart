import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Info.dart';

import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Course_evaluation_screens/My_Evaluation_screen.dart';
import 'Course_evaluation_screens/other_students_evaluation_screen.dart';
import 'Course_evaluation_screens/quiz_evaluation_screen.dart';
import 'Home.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'Last_quizzes.dart';
import 'Learning_analytics_screen.dart';
import 'Levels_View.dart';
import 'Sidebar/BlockNavigation.dart';
import 'classes/student.dart';
import 'myprofile_screen.dart';
import 'package:story_view/story_view.dart';

class Dashboard_screen extends StatefulWidget with NavigationStates  {
 // const Dashboard_screen({Key? key}) : super(key: key);
  final student std;
  Dashboard_screen(this.std);
  @override
  State<Dashboard_screen> createState() => _Dashboard_screenState(std);
}

class _Dashboard_screenState extends State<Dashboard_screen> {
  //int _selectedIndex = 3;
  final student std;
  static List<String> topics = <String>[
    "Nested Structures",
    "Arrays",
  ];
  _Dashboard_screenState(this.std);

  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(Dashboard_screen(std));
    _pages.add(levels_view(std));
    //_pages.add(Course_evual_categories(std, "CSW150"));
    _pages.add(lastQuizzes(std, "CSW150"));
    _pages.add(INFO(std, "CSW150"));

  }



  void _onItemTapped(int index) {
    setState(
          () {
        _selectedIndex = index;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => moveToPage(index)));
      },
    );
  }

  Widget moveToPage(int index) {

    return _pages.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    addTOList();
    final StoryController controller = StoryController();
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
       // elevation: 0.0,
        backgroundColor: Colors.blue[800],
        title: Text("Dashboard"),
        leading: Icon(Icons.dashboard),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,

        selectedItemColor: Colors.blue[800],
        selectedFontSize: 18,

        unselectedItemColor: Colors.grey,
        unselectedFontSize: 16,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            //   backgroundColor: Colors.blue
            //     backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_double_arrow_up),
            label: 'Levels',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.equalizer_outlined),
          //   label: 'Evaluation',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quizzes',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.only(top: 5.0),
         child: Container(
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.only(
               topLeft: Radius.circular(30),
               topRight: Radius.circular(30),
             ),
           ),
           child: Column(
             //mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 margin: EdgeInsets.all(
                   30,
                 ),
                 child: Column(
                   children: <Widget>[
                     Container(
                       height: 300,
                       child: StoryView(
                         controller: controller,
                         storyItems: [


                           StoryItem.text(
                             title:
                             "Hi "+std.name.toString().split(" ").first+"\n we hope to find you will \n what about taking a journey in the system",
                             backgroundColor: Color(0xFF1565C0),
                             roundedTop: true,
                           ),


                           StoryItem.inlineImage(
                             url:
                             "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
                             controller: controller,
                             caption: Text(
                               "Hektas, sektas and skatad",
                               style: TextStyle(
                                 color: Colors.white,
                                 backgroundColor: Colors.black54,
                                 fontSize: 17,
                               ),
                             ),
                           )
                         ],
                         onStoryShow: (s) {
                           print("Showing a story");
                         },
                         onComplete: () {
                           print("Completed a cycle");
                         },
                         progressPosition: ProgressPosition.top,
                         repeat: true,
                         inline: true,

                       ),
                     ),
                     Material(
                       child: InkWell(
                         onTap: () {
                           Navigator.of(context).push(
                               MaterialPageRoute(builder: (context) => MoreStories()));
                         },
                         child: Container(
                         //  height: 300,
                           //width: 300,
                           decoration: BoxDecoration(
                               color: Colors.black54,
                               borderRadius:
                               BorderRadius.vertical(bottom: Radius.circular(8))),
                           padding: EdgeInsets.symmetric(vertical: 8),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Text(
                                 "View more stories",
                                 style: TextStyle(fontSize: 16, color: Colors.white),
                               ),
                               SizedBox(
                                 width: 16,
                               ),
                               Icon(
                                 Icons.arrow_forward,
                                 color: Colors.white,
                               ),

                             ],
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(bottom: 20, top: 30,left: 30),
                 child: Text(
                   'Course Progress',
                   style: TextStyle(

                     fontSize: 25,
                     color: Colors.black,
                     fontWeight: FontWeight.w700,
                     fontStyle: FontStyle.italic,
                   ),
                 ),
               ), //course word
             Padding(
               padding: const EdgeInsets.only(left: 25,bottom:40),
               child: LinearPercentIndicator(
                     width: MediaQuery.of(context).size.width - 50,
                     animation: true,
                     lineHeight: 30,
                     animationDuration: 2000,
                     percent: 0.9,
                     center: Text(
                         "90.0%",style: TextStyle(
                       color: Colors.white
                     ),
                     ),
                     linearStrokeCap: LinearStrokeCap.roundAll,
                     progressColor: Colors.blue[800],
                   ),
             ),

               // Padding(
               //   padding: const EdgeInsets.only(bottom: 20, top: 30,left: 30),
               //   child: Text(
               //     'Current Topic',
               //     style: TextStyle(
               //
               //       fontSize: 25,
               //       color: Colors.black,
               //       fontWeight: FontWeight.w700,
               //       fontStyle: FontStyle.italic,
               //     ),
               //   ),
               // ), // word
               Row(
                 children: [
                   Spacer(),
                   Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(bottom: 20, top: 30),
                         child: Text(
                           'Current Level',
                           style: TextStyle(

                             fontSize: 25,
                             color: Colors.black,
                             fontWeight: FontWeight.w700,
                             fontStyle: FontStyle.italic,
                           ),
                         ),
                       ), // word
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: GestureDetector(
                           onTap: () {
                             // Navigator.push(
                             //     context,
                             //     MaterialPageRoute(
                             //         builder: (context) => My_Evaluation(std)));
                           },
                           child: Container(
                             height: 70,
                             width: 150,
                             decoration: BoxDecoration(
                                 color: Colors.blue[800],
                                 borderRadius: BorderRadius.circular(15.0)),
                             // padding: const EdgeInsets.only(
                             //     left: 10, top: 30.0, bottom: 30),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   "Level 1 ",
                                   style: TextStyle(fontSize: 16, color: Colors.white),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),//My_Evaluation
                     ],
                   ),
                   Spacer(),
                   Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(bottom: 20, top: 30),
                         child: Text(
                           'Current Topic',
                           style: TextStyle(

                             fontSize: 25,
                             color: Colors.black,
                             fontWeight: FontWeight.w700,
                             fontStyle: FontStyle.italic,
                           ),
                         ),
                       ), // word
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: GestureDetector(
                           onTap: () {
                             // Navigator.push(
                             //     context,
                             //     MaterialPageRoute(
                             //         builder: (context) => My_Evaluation(std)));
                           },
                           child: Container(
                             height: 70,
                             width: 150,
                             decoration: BoxDecoration(
                                 color: Colors.blue[800],
                                 borderRadius: BorderRadius.circular(15.0)),
                             // padding: const EdgeInsets.only(
                             //     left: 10, top: 30.0, bottom: 30),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   "Revision, Variables & Constants",
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: TextStyle(fontSize: 16, color: Colors.white),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),//My_Evaluation
                     ],
                   ),
                   Spacer(),
                 ],
               ),


               SizedBox(height: 30),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ExpansionTile(
                               title:Text("High Score Topics",style: TextStyle(color: Colors.white,fontSize: 25),),

                               children: [
                                 Container(
                                   height: 150,
                                   child: ListView.builder(
                                     itemCount:topics.length ,
                                     itemBuilder: (context,index){
                                       return ListTile(
                                         title:  Text(
                                           topics[index].toString()
                                             ,style: TextStyle(color: Colors.white,fontSize: 17),


                                         ),
                                       );
                                     },
                                   ),
                                 ),
                               ],
                             ),
                ),
              ),//high_score_topics
               SizedBox(height: 30),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
                 child: Container(
                   width: double.infinity,
                   decoration: BoxDecoration(
                       color: Colors.blue[800],
                       borderRadius: BorderRadius.circular(15.0)),
                   child: ExpansionTile(
                     title:Text("Low Score Topics",style: TextStyle(color: Colors.white,fontSize: 25),),

                     children: [
                       Container(
                         height: 150,
                         child: ListView.builder(
                           itemCount:topics.length ,
                           itemBuilder: (context,index){
                             return ListTile(
                               title:  Text(
                                 topics[index].toString()
                                 ,style: TextStyle(color: Colors.white,fontSize: 17),


                               ),
                             );
                           },
                         ),
                       ),
                     ],
                   ),
                 ),
               ),//low_score_topics







               Padding(
                 padding: const EdgeInsets.only(bottom: 20, top: 50,left: 30),
                 child: Text(
                   'Course Evaluation',
                   style: TextStyle(
                     fontSize: 25,
                     color: Colors.black,
                     fontWeight: FontWeight.w700,
                     fontStyle: FontStyle.italic,
                   ),
                 ),
               ), //course word

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 60),
                 child: GestureDetector(
                   onTap: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => My_Evaluation(std)));
                   },
                   child: Container(
                     height: 70,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(15.0)),
                     // padding: const EdgeInsets.only(
                     //     left: 10, top: 30.0, bottom: 30),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "My Evaluation ",
                           style: TextStyle(fontSize: 16, color: Colors.white),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),//My_Evaluation
               SizedBox(height: 20),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 60),
                 child: GestureDetector(
                   onTap: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>
                                 Other_students_evaluation_screen(std)));
                   },
                   child: Container(
                     height: 70,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(15.0)),
                     // padding: const EdgeInsets.only(
                     //     left: 10, top: 30.0, bottom: 30),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "    ME VS Other Students",
                           style: TextStyle(fontSize: 16, color: Colors.white),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),//Me VS Other
               SizedBox(height: 20),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 60),
                 child: GestureDetector(
                   onTap: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => quiz_evaluation_screen(std)));
                   },
                   child: Container(
                     height: 70,
                     width: double.infinity,
                     decoration: BoxDecoration(
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(15.0)),
                     // padding: const EdgeInsets.only(
                     //     left: 10, top: 30.0, bottom: 30),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "Quiz Evaluation ",
                           style: TextStyle(fontSize: 16, color: Colors.white),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),//Quiz_Evaluation

               SizedBox(height: 20),





             ],
           ),
         ),
       ),
     ),
    );
  }
}
class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();



  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
         icon: Icon(Icons.arrow_back_ios_outlined),
         onPressed: () {

         },
       ),
      ),
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "I guess you'd love to see more of the system. That's great.",
            backgroundColor: Color(0xFF1565C0),
          ),
          StoryItem.text(
            title: "Nice!\n\nTap to continue.",
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontFamily: 'Dancing',
              fontSize: 40,
            ),
          ),
          // StoryItem.pageImage(
          //   url:
          //   "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
          //   caption: "Still sampling",
          //   controller: storyController,
          // ),
          StoryItem.pageImage(
              url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
              caption: "Working with gifs",
              controller: storyController),
          // StoryItem.pageImage(
          //   url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
          //   caption: "Hello, from the other side",
          //   controller: storyController,
          // ),
          // StoryItem.pageImage(
          //
          //   url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
          //   caption: "Hello, from the other side2",
          //   controller: storyController,
          // ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
