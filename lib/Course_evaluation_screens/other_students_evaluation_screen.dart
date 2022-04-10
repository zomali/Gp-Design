import 'package:flutter/material.dart';
import 'package:gp/Course_evaluation_screens/Courses_evaluations.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import '../classes/student.dart';
class Other_students_evaluation_screen extends StatefulWidget {
  const Other_students_evaluation_screen({Key? key}) : super(key: key);

  @override
  State<Other_students_evaluation_screen> createState() => _Other_students_evaluation_screenState();
}

class _Other_students_evaluation_screenState extends State<Other_students_evaluation_screen> {
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
            ],

          ),
        ),
      ),
    );
  }
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
