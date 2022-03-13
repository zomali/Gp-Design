import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagePage extends StatefulWidget {
  @override _ImagePageState createState() => _ImagePageState();
}
class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2D Arrays'),
      ),
     body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(32),
        child: ElevatedButton(
          child: Text('open url'),
          onPressed: ()async
          {
            final url='https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/2D%20Arrays%2FEnglish%2F2D%20Arrays.pdf?alt=media&token=3ff61101-9c37-41c1-9092-1aeeba7962f8';
            OpenBrowserURL(url: url,inApp: true);
          },
        )
      ),
    );
  }
  Future OpenBrowserURL({
  required String url,
    bool inApp=false,
  })async{
    if(await canLaunch(url))
      {
        await launch(
          url,
           forceSafariVC: inApp,
           forceWebView: inApp,
           enableJavaScript: true,
        );
        }
      }  
}