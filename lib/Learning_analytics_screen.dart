import 'package:flutter/material.dart';

import 'package:gp/L_types.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import 'Course_evaluation_screens/Courses_evaluations.dart';
import 'Home.dart';
import 'Levels_View.dart';
import 'classes/student.dart';
import 'package:pie_chart/pie_chart.dart';

class Learning_analytics_screen extends StatefulWidget {
  final student std;
  Learning_analytics_screen(this.std);
  @override
  _Learning_analytics_screenState createState() =>
      _Learning_analytics_screenState(std);
}

class _Learning_analytics_screenState extends State<Learning_analytics_screen> {
  int _selectedIndex = 1;
  final student std;
  _Learning_analytics_screenState(this.std);
  static List<Widget> _pages = <Widget>[];
  Map<String, double> dataMap = {
    "Video": 6,
    "Audio": 3,
    "Text": 2,
    "Image": 4,
  };

  void addTOList() {
    _pages.add(levels_view(std));
    _pages.add(Learning_analytics_screen(std));
    _pages.add(Course_evual_categories(std));
    _pages.add(MyProfileScreen(std));
  }

  void _onItemTapped(int index) {
    setState(
          () {
            index%=4;
        _selectedIndex = index;

        //   print("index = ${widget.ind} ");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => moveToPage(index)));
      },
    );
  }

  Widget moveToPage(int index) {
    _selectedIndex%=4;
    return _pages.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    addTOList();
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
                child: PieChart(dataMap: dataMap,gradientList: gradientList,
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
      ),
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
      new level_time('Video', 7),
      new level_time('Audio', 11),
      new level_time('Text', 9),
      new level_time('Image', 15),


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
