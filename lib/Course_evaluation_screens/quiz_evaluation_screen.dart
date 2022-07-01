import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Course_evaluation_screens/Courses_evaluations.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gp/Dashboard_screen.dart';
import 'package:gp/analysis_controller.dart';
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

Text cluster(Student_perf student_perf) {
  if (student_perf.typeOfStudentCluster == "Fail" ||
      student_perf.typeOfStudentCluster == "so bad") {
    return Text(
      "  Yor performance need to be enhanced,your performance is so weak",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.red),
    );
  } else if (student_perf.typeOfStudentCluster == "Good") {
    return Text(
      "Yor performance is good but need to be enhanced more",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.blue[800]),
    );
  } else if (student_perf.typeOfStudentCluster == "Excellent") {
    return Text(
      "Yor performance is awesome keep going, you with " +
          student_perf.lengthOfCluster.toString() +
          " students are in the top",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.green),
    );
  } else {
    return Text(
      "",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
    );
  }
}

Text studentGradesView(List<int> listForOneGrades) {
  if (listForOneGrades[0] == 0) {
    return Text(
      "You didn't take any quiz until now",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
  } else if (listForOneGrades[4] != 0) {
    return Text(
      "You toke all level's quizzes",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
  } else {
    for (int i = 0; i < 5; i++) {
      if (listForOneGrades[i] == 0) {
        return Text(
          "You toke only " + i.toString() + " level's quizzes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        );
      }
    }
  }
  return Text(
    "some thing wrong",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    ),
  );
}

Student_perf student_perf = Student_perf();

class _quiz_evaluation_screenState extends State<quiz_evaluation_screen> {
  student std;
  _quiz_evaluation_screenState(this.std);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text("Courses Evaluation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Dashboard_screen(std)));
          },
        ),
      ),
      body: Builder(builder: (context) {
        StudentBehaviorCubit.get(context).fetchStudentGrades(std);
        StudentBehaviorCubit.get(context).cluster_performence(std.id);
        return BlocBuilder<StudentBehaviorCubit, StudentBehaviorState>(
          builder: (context, state) {
            if (state is StudentBehaviorLoading)
              return Center(child: CircularProgressIndicator());
            else {
              var studentCubit = StudentBehaviorCubit.get(context);
              student_perf.typeOfStudentCluster = "";
              try {
                listForOneGrades = studentCubit.gradesStudent;
                student_perf = studentCubit.student_perf;
              } catch (e) {
                for (int i = 0; i < 5; i++) {
                  listForOneGrades.add(1);
                }
                student_perf.typeOfStudentCluster = "";
              }

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),

                      Text(
                        "Average Quiz Scores",
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
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      studentGradesView(listForOneGrades),
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "By analysis your grades with other studends",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.blue[800]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      cluster(student_perf), //quiz chart
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
