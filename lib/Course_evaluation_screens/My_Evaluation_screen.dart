import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Course_evaluation_screens/Courses_evaluations.dart';
import 'package:gp/Dashboard_screen.dart';
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../classes/student.dart';

class My_Evaluation extends StatefulWidget {
  final student std;
  My_Evaluation(this.std);

  @override
  State<My_Evaluation> createState() => _My_EvaluationState(std);
}

var list;

class _My_EvaluationState extends State<My_Evaluation> {
  final student std;
  _My_EvaluationState(this.std);
  static List<String> topics = <String>[
    "Nested Structures",
    "Arrays",
  ];

  String percent = "10";
  double percentInNmber = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text("Courses Evaluation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard_screen(std)));
          },
        ),
      ),
      body: Builder(builder: (context) {
        StudentBehaviorCubit.get(context).getTimeTokenForEachLevel(std);
        StudentBehaviorCubit.get(context).getCurrentTopicPercet(std);
        return BlocBuilder<StudentBehaviorCubit, StudentBehaviorState>(
          builder: (context, state) {
            if (state is StudentBehaviorLoading)
              return Center(child: CircularProgressIndicator());
            else {
              var studentCubit = StudentBehaviorCubit.get(context);
              list = studentCubit.times;
              try {
                percent = studentCubit.percent;
                percentInNmber = double.parse(percent);
                percentInNmber /= 100;
              } catch (e) {}
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
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
                        percent: percentInNmber,
                        // backgroundColor: Colors.white,
                        animationDuration: 3000,
                        progressColor: Colors.blue[800],
                        center: Text(
                          percent + "%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),

                        circularStrokeCap: CircularStrokeCap.round,
                        // progressColor: Colors.deepOrange,
                      ),

                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Topics Of Weakness ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 50, left: 50, bottom: 50, top: 10),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Container(
                            height: 60 * topics.length.toDouble(),
                            width: double.infinity,
                            child: ListView.separated(
                              itemCount: topics.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 50,
                                  //    margin: EdgeInsets.only(left: 20),

                                  decoration: BoxDecoration(
                                      color: Colors.blue[800],
                                      borderRadius:
                                          BorderRadius.circular(15.0)),

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
                        height: 80,
                      ),
                      Text(
                        "Time Taken For Each Level (in minutes)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                            height: 300,
                            width: double.infinity,
                            child: CustomRoundedBars.withSampleData()),
                      ), //levels time chart

                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
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
      new level_time('Level 1', list[0]),
      new level_time('Level 2', list[1]),
      new level_time('Level 3', list[2]),
      new level_time('Level 4', list[3]),
      new level_time('Level 5', list[4]),
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
