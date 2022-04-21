import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/Course_evaluation_screens/Courses_evaluations.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gp/shared/cubits/cubit/student_behavior_cubit.dart';
import '../classes/student.dart';

class Other_students_evaluation_screen extends StatefulWidget {
  final student std;
  Other_students_evaluation_screen(this.std);
  @override
  State<Other_students_evaluation_screen> createState() =>
      _Other_students_evaluation_screenState(std);
}

List<int> listForAll = [];
List<int> listForOne = [];
List<int> listForOneGrades = [];
List<int> listForAllGrades = [];

class _Other_students_evaluation_screenState
    extends State<Other_students_evaluation_screen> {
  student std;
  _Other_students_evaluation_screenState(this.std);

  Text yourProgress(List<int> you, List<int> other) {
    if (you[0] == 0) {
      return Text(
        "You have to start",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      );
    } else if ((you[1] == 0 && you[0] > other[0]) ||
        (you[2] == 0 && you[1] > other[1]) ||
        (you[3] == 0 && you[2] > other[2]) ||
        (you[3] == 0 && you[2] > other[2]) ||
        (you[4] == 0 && you[3] > other[3]) ||
        (you[4] > other[4])) {
      return Text(
        "Your Progress in this level is Awesome",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 20.0,
        ),
      );
    } else if ((you[1] == 0 && you[0] < other[0]) ||
        (you[2] == 0 && you[1] < other[1]) ||
        (you[3] == 0 && you[2] < other[2]) ||
        (you[3] == 0 && you[2] < other[2]) ||
        (you[4] == 0 && you[3] < other[3]) ||
        (you[4] < other[4])) {
      return Text(
        "You have to improve your Progress",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 20.0,
        ),
      );
    } else {
      return Text(
        "Your Progress is Normal",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontSize: 18.0,
        ),
      );
    }
  }

  Text yourGrades(List<int> you, List<int> other) {
    if (you[0] == 0) {
      return Text(
        "You have to start",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      );
    } else if ((you[1] == 0 && you[0] > other[0]) ||
        (you[2] == 0 && you[1] > other[1]) ||
        (you[3] == 0 && you[2] > other[2]) ||
        (you[3] == 0 && you[2] > other[2]) ||
        (you[4] == 0 && you[3] > other[3]) ||
        (you[4] > other[4])) {
      return Text(
        "Your Grades in this level is Awesome",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 20.0,
        ),
      );
    } else if ((you[1] == 0 && you[0] < other[0]) ||
        (you[2] == 0 && you[1] < other[1]) ||
        (you[3] == 0 && you[2] < other[2]) ||
        (you[3] == 0 && you[2] < other[2]) ||
        (you[4] == 0 && you[3] < other[3]) ||
        (you[4] < other[4])) {
      return Text(
        "You have to improve your Grades",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 20.0,
        ),
      );
    } else {
      return Text(
        "Your Grades is Normal",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          fontSize: 18.0,
        ),
      );
    }
  }

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
                    builder: (context) => Course_evual_categories(std, "CSW150")));
          },
        ),
      ),
      body: Builder(builder: (context) {
        StudentBehaviorCubit.get(context).fetchStudentGrades(std);
        StudentBehaviorCubit.get(context).fetchAllStudentGrades(std);
        StudentBehaviorCubit.get(context).getTimeTokenForEachLevel(std);
        StudentBehaviorCubit.get(context)
            .getTimeTokenForEachLevelForAllStudents(std);
        return BlocBuilder<StudentBehaviorCubit, StudentBehaviorState>(
          builder: (context, state) {
            if (state is StudentBehaviorLoading)
              return Center(child: CircularProgressIndicator());
            else {
              var studentCubit = StudentBehaviorCubit.get(context);
              try {
                listForAll = studentCubit.timesForStudents;
                listForOne = studentCubit.times;
                listForOneGrades = studentCubit.gradesStudent;
                listForAllGrades = studentCubit.gradesAllStudent;
              } catch (e) {
                for (int i = 0; i < 5; i++) {
                  listForAll.add(1);
                  listForOne.add(1);
                  listForOneGrades.add(1);
                  listForAllGrades.add(1);
                }
              }
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        "Your Progress VS Other Students Progress",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "(By time spent in each level)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      yourProgress(listForOne, listForAll),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          child: StackedAreaLineChart.withSampleData(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Text(
                        "Your Progress is the Green color",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Other Student Progress is the Blue color",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16.0,
                        ),
                      ), // compare graph
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
                      Text(
                        "(By Grades in each quiz)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      yourGrades(listForOneGrades, listForAllGrades),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          child: StackedAreaLineChart1.withSampleData(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Text(
                        "Your Grades is the Green color",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Other Student Grades is the Blue color",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16.0,
                        ),
                      ), // compare graph
                      SizedBox(
                        height: 50,
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
    return new charts.LineChart(_createSampleData(),
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<compare_progress, int>> _createSampleData() {
    final myFakeDesktopData = [
      new compare_progress(0, 0),
      new compare_progress(1, listForAll[0]),
      new compare_progress(2, listForAll[1]),
      new compare_progress(3, listForAll[2]),
      new compare_progress(4, listForAll[3]),
      new compare_progress(5, listForAll[4]),
      //new compare_progress(5, 75),
    ];

    var myFakeTabletData = [
      new compare_progress(0, 0),
      new compare_progress(1, listForOne[0]),
      new compare_progress(2, listForOne[1]),
      new compare_progress(3, listForOne[2]),
      new compare_progress(4, listForOne[3]),
      new compare_progress(5, listForOne[4]),
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
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (compare_progress sales, _) => sales.level,
        measureFn: (compare_progress sales, _) => sales.compelted,
        data: myFakeTabletData,
      ),
    ];
  }
}

class StackedAreaLineChart1 extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart1(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaLineChart1.withSampleData() {
    return new StackedAreaLineChart1(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(_createSampleData(),
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<compare_progress1, int>> _createSampleData() {
    // print(listForOneGrades[0]);
    // print(listForAllGrades[0]);
    // print(listForOneGrades[1]);
    // print(listForAllGrades[1]);
    final myFakeDesktopData1 = [
      new compare_progress1(0, 0),
      new compare_progress1(1, listForAllGrades[0]),
      new compare_progress1(2, listForAllGrades[1]),
      new compare_progress1(3, listForAllGrades[2]),
      new compare_progress1(4, listForAllGrades[3]),
      new compare_progress1(5, listForAllGrades[4]),
      //new compare_progress(5, 75),
    ];

    var myFakeTabletData1 = [
      new compare_progress1(0, 0),
      new compare_progress1(1, listForOneGrades[0]),
      new compare_progress1(2, listForOneGrades[1]),
      new compare_progress1(3, listForOneGrades[2]),
      new compare_progress1(4, listForOneGrades[3]),
      new compare_progress1(5, listForOneGrades[4]),
      // new compare_progress(5, 75),
    ];

    return [
      new charts.Series<compare_progress1, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (compare_progress1 sales, _) => sales.level,
        measureFn: (compare_progress1 sales, _) => sales.compelted,
        data: myFakeDesktopData1,
      ),
      new charts.Series<compare_progress1, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (compare_progress1 sales, _) => sales.level,
        measureFn: (compare_progress1 sales, _) => sales.compelted,
        data: myFakeTabletData1,
      ),
    ];
  }
}

class compare_progress1 {
  final int level;
  final int compelted;

  compare_progress1(this.level, this.compelted);
}

class compare_progress {
  final int level;
  final int compelted;

  compare_progress(this.level, this.compelted);
}
