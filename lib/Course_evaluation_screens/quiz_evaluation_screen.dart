import 'package:flutter/material.dart';
import 'package:gp/Course_evaluation_screens/Courses_evaluations.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import '../classes/student.dart';

class quiz_evaluation_screen extends StatefulWidget {
  const quiz_evaluation_screen({Key? key}) : super(key: key);

  @override
  State<quiz_evaluation_screen> createState() => _quiz_evaluation_screenState();
}

class _quiz_evaluation_screenState extends State<quiz_evaluation_screen> {
  final student std=new student();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: const Text("Courses Evaluation"),
    leading: IconButton(
    icon: Icon(Icons.arrow_back_ios_outlined),
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => Course_evual_categories(std)));

    },
    ),
    ),
    body: SingleChildScrollView(
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
              padding: const EdgeInsets.symmetric( horizontal: 50),
              child: Container(
                  height: 300,
                  width: double.infinity,
                  child: SimpleBarChart.withSampleData()
              ),
            ),//quiz chart
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
