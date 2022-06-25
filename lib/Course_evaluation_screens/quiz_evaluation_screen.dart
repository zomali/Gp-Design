import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Course_evaluation_screens/Courses_evaluations.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gp/Dashboard_screen.dart';
import '../classes/student.dart';
import '../shared/cubits/cubit/student_behavior_cubit.dart';

class quiz_evaluation_screen extends StatefulWidget {
  final student std;
  quiz_evaluation_screen(this.std);

  @override
  State<quiz_evaluation_screen> createState() =>
      _quiz_evaluation_screenState(std);
}

List<int> listForOneGrades = [];

class _quiz_evaluation_screenState extends State<quiz_evaluation_screen> {
  student std;
  _quiz_evaluation_screenState(this.std);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses Evaluation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Dashboard_screen(std)));
          },
        ),
      ),
      body: Builder(builder: (context) {
        StudentBehaviorCubit.get(context).fetchStudentGrades(std);
        return BlocBuilder<StudentBehaviorCubit, StudentBehaviorState>(
          builder: (context, state) {
            if (state is StudentBehaviorLoading)
              return Center(child: CircularProgressIndicator());
            else {
              var studentCubit = StudentBehaviorCubit.get(context);
              try {
                listForOneGrades = studentCubit.gradesStudent;
              } catch (e) {
                for (int i = 0; i < 5; i++) {
                  listForOneGrades.add(1);
                }
              }
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
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
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                            height: 300,
                            width: double.infinity,
                            child: SimpleBarChart.withSampleData()),
                      ), //quiz chart
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
      new quiz_grades('Quiz 1', listForOneGrades[0]),
      new quiz_grades('Quiz 2', listForOneGrades[1]),
      new quiz_grades('Quiz 3', listForOneGrades[2]),
      new quiz_grades('Quiz 4', listForOneGrades[3]),
      new quiz_grades('Quiz 5', listForOneGrades[4]),
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
