import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp/ApiService.dart';

import 'L_types.dart';
import 'Levels.dart';

class PdfViewerPage extends StatefulWidget {
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}
class _PdfViewerPageState extends State<PdfViewerPage> {
  late String localPath;
  @override
  void initState() {
    // TODO: implement initState
    try {
      super.initState();

      ApiServiceProvider.loadPDF().then((value) {
        setState(() {
          localPath = value;
        });
      });
    }
    on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "Ops! Login Failed, ${e.message} ",
          toastLength: Toast.LENGTH_LONG,
          //    gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0
      );


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2D Array"),
        elevation: 1,

        backgroundColor: Colors.blue,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            //   _player.pause();
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> types()));

            // _selectedIndex-=2;

          },),

      ),
      body:

      localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),




    );
  }
}