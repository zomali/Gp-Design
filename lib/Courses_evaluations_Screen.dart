import 'package:flutter/material.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Learning_analytics_screen.dart';
import 'package:gp/audio_player.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'Home.dart';
import 'Types.dart';
import 'classes/student.dart';

class Courses_evaluations_Screen extends StatefulWidget {
  final student std;
  Courses_evaluations_Screen(this.std);

  @override
  _Courses_evaluations_ScreenState createState() =>
      _Courses_evaluations_ScreenState(std);
}

class _Courses_evaluations_ScreenState
    extends State<Courses_evaluations_Screen> {
  final student std;
  _Courses_evaluations_ScreenState(this.std);
  int _selectedIndex = 2;
  static List<Widget> _pages = <Widget>[];

  void addTOList() {
    _pages.add(Home(std));
    _pages.add(Learning_analytics_screen(std));
    _pages.add(Courses_evaluations_Screen(std));
    _pages.add(MyProfileScreen(std));
  }
  static List <String>topics=<String>[
    "Nested Structures & Passing Structures To Funct...",
    "Arrays",



  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;

        //   print("index = ${widget.ind} ");
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses Evaluation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home(std)));
            _selectedIndex -= 2;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,

        selectedItemColor: Colors.blue,
        selectedFontSize: 16,

        unselectedItemColor: Colors.grey,
        // unselectedFontSize: 11,
        unselectedFontSize: 16,

        //    currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //backgroundColor: Colors.blue,
            //   backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            //  icon: Icon(Icons.up),
            label: 'Analytics',

            // backgroundColor: Colors.blue,
            //     backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer_outlined),
            label: 'Evaluation',
            //  backgroundColor: Colors.blue
            //    backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Dashboard',
            //   backgroundColor: Colors.blue
            //     backgroundColor: Colors.blue,
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
        child: Center(
          child:Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(

                  "Topics Of Weakness ",


                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:  50,left: 50,bottom: 50,top: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => audio_player()),
                      ),
                    },
                    child: Container(
                      height: 70*topics.length.toDouble(),
                      width: double.infinity,

                      child: ListView.separated(
                          itemCount: topics.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(

                              height: 50,
                          //    margin: EdgeInsets.only(left: 20),

                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15.0)),

                              child: Center(
                                  child: Text(

                                    '${topics[index]}',

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textScaleFactor: 1,
                                    textDirection: TextDirection.rtl,


                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        debugLabel: "Hazem",
                                   //   fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                      height: 17,
                    ),
                          ),
                    ),
                  ),
                ),






                SizedBox(
                  height: 30,
                ),
                Text(
                  "Completed Levels ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CircularPercentIndicator(
                  radius: 180.0,
                  lineWidth: 20.0,
                  animation: true,
                  percent: 0.4,
                  // backgroundColor: Colors.white,
                  animationDuration: 3000,
                  progressColor: Colors.blue,
                  center: Text(
                    "40%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),

                  circularStrokeCap: CircularStrokeCap.round,
                  // progressColor: Colors.deepOrange,
                ),
                SizedBox(
                  height: 100,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Row(
                //     children: [
                //       Spacer(),
                //       Column(
                //         children: [
                //           Text(
                //             "Completed Levels ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20.0,
                //             ),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           CircularPercentIndicator(
                //             radius: 150.0,
                //             lineWidth: 20.0,
                //             animation: true,
                //             percent: 0.2,
                //             // backgroundColor: Colors.white,
                //             animationDuration: 3000,
                //             progressColor: Colors.blue,
                //             center: Text(
                //               "20%",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20.0,
                //               ),
                //             ),
                //
                //             circularStrokeCap: CircularStrokeCap.round,
                //             // progressColor: Colors.deepOrange,
                //           ),
                //         ],
                //       ),
                //       Spacer(),
                //       Column(
                //         children: [
                //           Text(
                //             "Completed Levels ",
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20.0,
                //             ),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           CircularPercentIndicator(
                //             radius: 150.0,
                //             lineWidth: 20.0,
                //             animation: true,
                //             percent: 0.6,
                //             // backgroundColor: Colors.white,
                //             animationDuration: 3000,
                //             progressColor: Colors.blue,
                //             center: Text(
                //               "60%",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20.0,
                //               ),
                //             ),
                //
                //             circularStrokeCap: CircularStrokeCap.round,
                //             // progressColor: Colors.deepOrange,
                //           ),
                //         ],
                //       ),
                //       Spacer(),
                //     ],
                //   ),
                // ),


                Text(
                  "Your Progress VS Other Students Progress",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 50),
                  child: Container(
                      height: 300,
                      width: double.infinity,
                      child:  StackedAreaLineChart.withSampleData(),
                  ),
                ),// compare graph

                SizedBox(
                  height: 80,
                ),

                Text(
                  "Quiz Scores",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.symmetric( horizontal: 50),
                 child: Container(
                   height: 300,
                     width: double.infinity,
                     child: SimpleBarChart.withSampleData()
                 ),
               ),//quiz chart


                SizedBox(
                  height: 100,
                ),
                Text(
                  "Time Taken For Each Level (in days)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 50),
                  child: Container(
                      height: 300,
                      width: double.infinity,
                      child: CustomRoundedBars.withSampleData()
                  ),
                ),//levels time chart

                SizedBox(
                  height: 100,
                ),





              ],
            ),
          ),
      ),

    );
  }

}


class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {required this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,


    );
  }
  static List<charts.Series<dynamic, String>> _createSampleData() {
    final data = [
      new quiz_grades('Quiz 1', 65),
      new quiz_grades('Quiz 2', 85),
      new quiz_grades('Quiz 3', 100),
      new quiz_grades('Quiz 4', 95),
      new quiz_grades('Quiz 5', 35),

    ];

    return [
      new charts.Series<quiz_grades, String>(
        id: 'Quiz',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (quiz_grades quiz, _) => quiz.quiz,
        measureFn: (quiz_grades quiz, _) => quiz.precent,
        data: data,
       // labelAccessorFn: (add_quiz quiz, _) => quiz.precent.toString(),
      //  overlaySeries: true

      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
        _createSampleData(),


    );
  }
}
class quiz_grades {
  final String quiz;
  final int precent;

  quiz_grades(this.quiz, this.precent);
}





class CustomRoundedBars extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomRoundedBars(this.seriesList, {required this.animate});

  /// Creates a [BarChart] with custom rounded bars.
  factory CustomRoundedBars.withSampleData() {
    return new CustomRoundedBars(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      _createSampleData(),
      animate: animate,
      defaultRenderer: new charts.BarRendererConfig(
        // By default, bar renderer will draw rounded bars with a constant
        // radius of 100.
        // To not have any rounded corners, use [NoCornerStrategy]
        // To change the radius of the bars, use [ConstCornerStrategy]
          cornerStrategy: const charts.ConstCornerStrategy(30)),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<level_time, String>> _createSampleData() {
    final data = [
      new level_time('Level 1', 7),
      new level_time('Level 2', 11),
      new level_time('Level 3', 9),
      new level_time('Level 4', 15),
      new level_time('Level 5', 20),

    ];

    return [
      new charts.Series<level_time, String>(
        id: 'Time',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (level_time sales, _) => sales.level,

        measureFn: (level_time sales, _) => sales.days,
        data: data,
      )
    ];
  }
}
class level_time {
  final String level;
  final int days;

  level_time(this.level, this.days);
}





class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaLineChart.withSampleData() {
    return new StackedAreaLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
       _createSampleData(),
        defaultRenderer:
        new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<compare_progress, int>> _createSampleData() {
    final myFakeDesktopData = [
      new compare_progress(0, 5),
      new compare_progress(1, 25),
      new compare_progress(2, 20),
      new compare_progress(3, 75),
      new compare_progress(4, 75),
      //new compare_progress(5, 75),
    ];

    var myFakeTabletData = [
      new compare_progress(0, 10),
      new compare_progress(1, 50),
      new compare_progress(2, 100),
      new compare_progress(3, 150),
      new compare_progress(4, 75),
     // new compare_progress(5, 75),
    ];



    return [
      new charts.Series<compare_progress, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (compare_progress sales, _) => sales.level,
        measureFn: (compare_progress sales, _) => sales.compelted,
        data: myFakeDesktopData,
      ),
      new charts.Series<compare_progress, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (compare_progress sales, _) => sales.level,
        measureFn: (compare_progress sales, _) => sales.compelted,
        data: myFakeTabletData,
      ),

    ];
  }
}
class compare_progress {
  final int level;
  final int compelted;

  compare_progress(this.level, this.compelted);
}
