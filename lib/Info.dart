import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Dashboard_screen.dart';
import 'package:gp/shared/cubits/cubit/course_cubit.dart';
import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Last_quizzes.dart';
import 'Levels_View.dart';
import 'package:gp/classes/classes.dart';
import 'classes/student.dart';
import 'package:carousel_slider/carousel_slider.dart';
class INFO extends StatefulWidget{
  final student std;
  final String courseCode;
  INFO(this.std, this.courseCode);
  @override
  State<INFO> createState() => _INFOState(std, courseCode);
}

class _INFOState extends State<INFO> {
   student std;
   String courseCode;
  _INFOState(this.std, this.courseCode);
  int _selectedIndex = 3;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(Dashboard_screen(std));
    _pages.add(levels_view(std));
   // _pages.add(Course_evual_categories(std, courseCode));
    _pages.add(lastQuizzes(std, courseCode));
    _pages.add(INFO(std, courseCode));
  }

  void _onItemTapped(int index) {
    setState(
          () {

            if(index== _selectedIndex) {

            }
            else
              {
                _selectedIndex = index;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => moveToPage(index)));
              }
      // _selectedIndex = index;

      },
    );
  }

  Widget moveToPage(int index) {

    return _pages.elementAt(_selectedIndex);
  }
 Widget instructor_card(@required Color color, @required String title, @required String supTitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10
      ),
      height: 120,
      width: MediaQuery.of(context).size.width-40,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            supTitle,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          )
        ],
      ),
    );
  }
 /*Widget random_card(@required Color color_, @required String title, @required String count){
   return Container(
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(10),
       border: Border.all(color: color_, width: 2),
     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Container(
           height: 50,
           child: Text(count, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),          
          ),
          SizedBox(height: 5,),
          Text(title, style:TextStyle(fontSize: 17))
       ],
     ),
   );
 }*/
  //carousal
   ScrollController scrollViewColtroller = ScrollController();
   final ScrollController controllerOne = ScrollController();
   final ScrollController controllerTwo = ScrollController();
   @override
   void initState() {
     scrollViewColtroller = ScrollController();
     scrollViewColtroller.addListener(_scrollListener);
     super.initState();
   }

   _scrollListener() {
     if (scrollViewColtroller.offset >=
         scrollViewColtroller.position.maxScrollExtent &&
         !scrollViewColtroller.position.outOfRange) {
       setState(() {
         message = "reach the bottom";
         _direction = true;
       });
     }
     if (scrollViewColtroller.offset <=
         scrollViewColtroller.position.minScrollExtent &&
         !scrollViewColtroller.position.outOfRange) {
       setState(() {
         message = "reach the top";
         _direction = false;
       });
     }
   }

   String message = '';
   bool _direction = false;

   @override
   void dispose() {
     super.dispose();
     scrollViewColtroller.dispose();
   }
   @override
  Widget build(BuildContext context ) {
    addTOList();

    return Scaffold(
      backgroundColor: Color(0xFF1565C0),
      appBar: AppBar(
        backgroundColor: Color(0xFF1565C0),
        title: Text('Structured Programming'),
        leading: const Icon(Icons.info),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,

        selectedItemColor: Color(0xFF1565C0),
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

      body: Builder(
        builder: (context) {
          CourseCubit.get(context).getCourseData(courseCode);
          return BlocBuilder<CourseCubit, CourseState>(
            builder: (context, state) {
              if (state is CourseLoading){
               return Center(child: CircularProgressIndicator());
              }
              else{
                var courseCubit = CourseCubit.get(context);
                var course = courseCubit.course;
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(

                   // height: 800,
                  //width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),

                   //   padding: const EdgeInsets.only(top: 30),
                      child: ListView(
                  //  controller: scrollViewColtroller,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric( horizontal: 25, vertical: 10),
                          height: 120,
                          child: Row(
                            children: [
                              Spacer(),
                              Column(
                                children: [
                                  Icon(Icons.keyboard_double_arrow_up, color: Colors.orange, size: 27,),
                                  Text("Levels", style: TextStyle(color: Colors.orange, fontSize: 17, fontWeight: FontWeight.bold),),
                                  Padding(padding: EdgeInsets.only(bottom: 3)),
                                  Text("5", style: TextStyle(fontSize: 23),),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                                //height: 80,
                                child: VerticalDivider(
                                  color: Colors.grey[200],
                                  width: 20,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                              Column(
                                children: [
                                  Icon(Icons.topic, color: Colors.indigo[800]!, size: 27,),
                                  Text("Topics", style: TextStyle(color: Colors.indigo[800]!, fontSize: 17, fontWeight: FontWeight.bold),),
                                  Padding(padding: EdgeInsets.only(bottom: 3)),
                                  Text("17", style: TextStyle(fontSize: 23),),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                                //height: 80,
                                child: VerticalDivider(
                                  color: Colors.grey[200],
                                  width: 20,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                              Column(
                                children: [
                                  Icon(Icons.quiz, color: Colors.yellowAccent[700]! , size: 27,),
                                  Text("Quizzes", style: TextStyle(color: Colors.yellowAccent[700]!, fontSize: 17, fontWeight: FontWeight.bold),),
                                  Padding(padding: EdgeInsets.only(bottom: 3)),
                                  Text("+20", style: TextStyle(fontSize: 23),),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                                //height: 80,
                                child: VerticalDivider(
                                  color: Colors.grey[200],
                                  width: 20,
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                              ),
                              Column(
                                children: [
                                  Icon(Icons.document_scanner, color: Colors.green[600]!, size: 27,),
                                  Text("Materials", style: TextStyle(color: Colors.green[600]!, fontSize: 17, fontWeight: FontWeight.bold),),
                                  Padding(padding: EdgeInsets.only(bottom: 3)),
                                  Text("+100", style: TextStyle(fontSize: 23),),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),//course info
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:30,top:25,bottom: 10),
                        child: Text("Instructors",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,)),),

                         Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              right: 10
                            ),
                            child: Container(
                              height: 120,
                              //width: double.infinity,
                          //     child: ListView.builder(
                          // //     controller: scrollViewColtroller,
                          //       controller: scrollViewColtroller,
                          //     //  padding:const EdgeInsets.only(left: 20,right: 20) ,
                          //       scrollDirection: Axis.horizontal,
                          //       shrinkWrap: true,
                          //       itemCount: course.instructors.length,
                          //       itemBuilder: (BuildContext context, int index){
                          //         return instructor_card(
                          //           Theme.of(context).colorScheme.secondary,
                          //           course.instructors[index].name,
                          //           course.instructors[index].contact);
                          //       },
                          //     ),
                              child: CarouselSlider.builder(
                                  itemCount: course.instructors.length,
                                  itemBuilder: (ctx, index, realIdx){
                                      return instructor_card(
                                             Theme.of(context).colorScheme.secondary,
                                                course.instructors[index].name,
                                               course.instructors[index].contact);
                                },
                                options: CarouselOptions(
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  autoPlay: true,

                                ),
                              ),
                            ),
                          ),


                        Padding(padding: EdgeInsets.only(left:30, top: 30),
                        child: Text("Learning Outcomes",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,)),),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18,
                            top: 10,
                            right: 10,
                          ),
                          child: Scrollbar(
                            thickness: 8,
                            isAlwaysShown: true,
                            interactive: true,
                            showTrackOnHover: true,
                            trackVisibility: true,
                            child: Container(

                                child: ListView.builder(
                                   controller: scrollViewColtroller,
                                 //   physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: course.learning_outcomes.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return Card(
                                      elevation: 8.0,
                                      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                      child: Container(
                                        decoration: BoxDecoration(color: Color(0xFF1565C0)),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                          leading: Container(
                                            padding: EdgeInsets.only(right: 12.0),
                                            decoration: new BoxDecoration(
                                              border: new Border(
                                                right: new BorderSide(width: 1.0, color: Colors.white24))),
                                                child: Icon(Icons.checklist_rounded, color: Colors.white),),
                                                title: Text(
                                                  course.learning_outcomes[index],
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),),
                                                  ),
                                                ),
                                );}
                                        ),

                                    ),
                          ),
                                ),
                      ],
                  ),


              ),
                );
              }
            },
          );

        }
      ),
      );

  }
}