import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class pdf_view extends StatefulWidget {

  @override
  _pdf_view createState() => _pdf_view();
}

class _pdf_view extends State<pdf_view> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SfPdfViewer.network(
              'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/Revision%2C%20Variables%20%26%20Constants%2FEnglish%2FRevision%2C%20Variables%20%26%20Constants.pdf?alt=media&token=cb4470fe-1b65-48fb-8924-e494e7b2515c',
              controller: _pdfViewerController,
              key: _pdfViewerStateKey),
          appBar: AppBar(
            title: Text('Revision, Variables & Constants'),
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
          ),
        ));
  }
}