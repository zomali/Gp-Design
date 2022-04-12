import 'package:flutter/material.dart';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Levels_View.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:gp/classes/classes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class pdf_view extends StatefulWidget {
  final student std;
  final Text_ text_;
  final ForText forText;
  final Level_ level;
  final Topic_ topic;
  pdf_view(this.std,this.text_, this.forText, this.level, this.topic);
  @override
  _pdf_view createState() => _pdf_view(std, text_, forText, level, topic);
}

class _pdf_view extends State<pdf_view> {
  student std;
  final Text_ text_;
  ForText forText;
  Level_ level;
  Topic_ topic;
  _pdf_view(this.std,this.text_, this.forText, this.level, this.topic);
  DatabaseManager db = DatabaseManager();
  int NumperOfEnters = 0;
  List<int> times = [];
  int i = 0;
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime initialTime = DateTime.now();
    final initialHour = initialTime.hour.toString().padLeft(2, '0');
    final initialMinute = initialTime.minute.toString().padLeft(2, '0');
    final initialSecond = initialTime.second.toString().padLeft(2, '0');

    String x = '$initialHour$initialMinute$initialSecond';
    int firstTime = int.parse(x);
    return SafeArea(
        child: Scaffold(
          
      body: SfPdfViewer.network(
          text_.URL,
          controller: _pdfViewerController,
          key: _pdfViewerStateKey),
      appBar: AppBar(
        title: Text(text_.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _pdfViewerStateKey.currentState!.openBookmarkView();
              },
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                //   _pdfViewerController.jumpToPage(5);
                _pdfViewerController.lastPage();
              },
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                //   _pdfViewerController.jumpToPage(5);
                _pdfViewerController.firstPage();
              },
              icon: Icon(
                Icons.arrow_drop_up_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                _pdfViewerController.zoomLevel = 3.25;
              },
              icon: Icon(
                Icons.zoom_in,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            try {
              for (int i = 1; i < 5; i++) {
                forText.Time_spent_every_once[i];
                NumperOfEnters++;
              }
            } catch (e) {}

            DateTime FinalTime = DateTime.now();
            final FinalHour = FinalTime.hour.toString().padLeft(2, '0');
            final FinalMinute = FinalTime.minute.toString().padLeft(2, '0');
            final FinalSecond = FinalTime.second.toString().padLeft(2, '0');
            x = '$FinalHour$FinalMinute$FinalSecond';
            int SecondTime = int.parse(x);
            int timeStayed = SecondTime - firstTime;
            ForText NewforText = ForText();
            NewforText.NumberOfVisitedPage = forText.NumberOfVisitedPage + 1;
            NewforText.TimeSpendInPage =
                forText.TimeSpendInPage + (SecondTime - firstTime);
            for (i = 0; i < 100; i++) {
              try {
                times.add(forText.Time_spent_every_once[i]);
                NumperOfEnters++;
              } catch (e) {
                times.add(timeStayed);
                break;
              }
            }
            db.updateStudentBehavior(
                NewforText.TimeSpendInPage,
                NewforText.NumberOfVisitedPage,
                "text",
                std.id,
                level.id,
                topic.id,
                times);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => types(std, level, topic)));
            // _selectedIndex-=2;
          },
        ),
      ),
    ));
  }
}
