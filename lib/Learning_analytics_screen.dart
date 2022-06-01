import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gp/L_types.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:gp/shared/cubits/cubit/topic_cubit.dart';
import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'DatabaseManager.dart';
import 'Home.dart';
import 'Levels_View.dart';
import 'Sidebar/BlockNavigation.dart';
import 'classes/classes.dart';
import 'classes/student.dart';
import 'package:pie_chart/pie_chart.dart';

import 'classes/studentBehavior.dart';

class Learning_analytics_screen extends StatefulWidget with NavigationStates  {
  final student std;
 // Level_ level;
 // Topic_ topic;
  Learning_analytics_screen(this.std);
  @override
  _Learning_analytics_screenState createState() =>
      _Learning_analytics_screenState(std);
}
List<int> times = [];
class _Learning_analytics_screenState extends State<Learning_analytics_screen> {
  int _selectedIndex = 1;
  final student std;

 // Level_ level;
 //  Topic_ topic;
  _Learning_analytics_screenState(this.std);
  late studentBehavior stdBehavior;
  DatabaseManager db = DatabaseManager();

  //late TypesForStudent list;
  var cupit;
  static List<Widget> _pages = <Widget>[];
  // Map<String, double> dataMap = {
  //   "Video": times[0].toDouble(),
  //   "Audio": times[1].toDouble(),
  //   "Text": times[2].toDouble(),
  //   "Image": times[3].toDouble(),
  // };
  static Map<String, double> get_data_map(double v,double a,double t,double i) {
    Map<String, double>  data = {

      "Video": v,
      "Audio": a,
      "Text": t,
      "Image":i,


    };

    return data;
  }

  @override
  Widget build(BuildContext context) {
    List<List<Color>> gradientList;
    gradientList = <List<Color>>[
      [
        Color.fromRGBO(223, 250, 92, 1),
        Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        Color.fromRGBO(129, 182, 205, 1),
        Color.fromRGBO(91, 253, 199, 1),
      ],
      [
        Color.fromRGBO(175, 63, 62, 1.0),
        Color.fromRGBO(254, 154, 92, 1),
      ]
    ];

// Pass gradient to PieChart

    return Scaffold(




      appBar: AppBar(
        title: const Text("Learning Analytics"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home(std)));
            _selectedIndex -= 1;
          },
        ),
      ),

      body: Builder(builder: (context) {
        StudentBehaviorCubit.get(context).getTimeTokenForEachContentType2(std);


        return BlocBuilder<StudentBehaviorCubit, StudentBehaviorState>(
            builder: (context, state) {
              if (state is StudentBehaviorLoading) {
                return Center(child: CircularProgressIndicator());
              }
              else {
                var behaviorCubit = StudentBehaviorCubit.get(context);

                 times=behaviorCubit.time;
                var map=get_data_map(times[0].toDouble(), times[1].toDouble(), times[2].toDouble(), times[3].toDouble());
                // print(times[0]);
                      //stdBehavior = behaviorCubit.std;
                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 50,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Time Taken For Each Type Of Content (in minutes)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
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


                              SizedBox(height: 50,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),

                                child: PieChart(dataMap:map,gradientList: gradientList,
                               // child: PieChart(dataMap: CustomRoundedBars.g(),gradientList: gradientList,
                                  emptyColorGradient: [
                                    Color(0xff6c5ce7),
                                    Colors.blue,
                                  ],baseChartColor: Colors.grey,
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                    showChartValueBackground: false,
                                    decimalPlaces: 0,
                                  ),
                                ),
                              ),
                              // PieChart(
                              //   dataMap: dataMap,
                              //   animationDuration: Duration(milliseconds: 800),
                              //   chartLegendSpacing: 32,
                              //   chartRadius: MediaQuery.of(context).size.width / 3.2,
                              //  // colorList: ,
                              //   initialAngleInDegree: 0,
                              //   chartType: ChartType.ring,
                              //   ringStrokeWidth: 32,
                              //   centerText: "HYBRID",
                              //   legendOptions: LegendOptions(
                              //     showLegendsInRow: false,
                              //     legendPosition: LegendPosition.right,
                              //     showLegends: true,
                              //  //   legendShape: _BoxShape.circle,
                              //     legendTextStyle: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              //   chartValuesOptions: ChartValuesOptions(
                              //     showChartValueBackground: true,
                              //     showChartValues: true,
                              //     showChartValuesInPercentage: false,
                              //     showChartValuesOutside: false,
                              //     decimalPlaces: 1,
                              //   ),
                              //   // gradientList: ---To add gradient colors---
                              //   // emptyColorGradient: ---Empty Color gradient---
                              // )

                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              }

            )
      );


  }
}
class CustomRoundedBars extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
 static Map<String, double> dataMap = {
    "Video": 10,
    "Audio": times[1].toDouble(),
    "Text": times[2].toDouble(),
    "Image": times[3].toDouble(),
  };
  CustomRoundedBars(this.seriesList, {required this.animate});

  /// Creates a [BarChart] with custom rounded bars.
  factory CustomRoundedBars.withSampleData() {
    return new CustomRoundedBars(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }
 static Map<String, double> g(){
    return dataMap;
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

      new level_time('Video', times[0]),
      new level_time('Audio', times[1]),
      new level_time('Text', times[2]),
      new level_time('Image', times[3]),


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
  static Map<String, double> get_data_map(double v,double a,double t,double i) {
    try {
      Map<String, double> data = {

        "Video": 10,
        "Audio": 10,
        "Text": 20,
        "Image": 20,


      };

      return data;
    }
    catch (e)
    {
      Map<String, double> data = {

        "Video": 10,
        "Audio": 10,
        "Text": 10,
        "Image": 10,


      };

      return data;
    }
  }

}
class level_time {
  final String level;
  final int days;

  level_time(this.level, this.days);
}