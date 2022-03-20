import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Home.dart';
import 'package:gp/Levels.dart';
import 'package:gp/Types.dart';
import 'package:gp/myprofile_screen.dart';
import 'package:gp/pdf_view.dart';
import 'package:gp/topic_images.dart';
import 'audio_player.dart';
import 'package:gp/URL_view.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class types extends StatefulWidget {
  int _selectedIndex = 3;
  static  List<Widget> _pages = <Widget>[
    Home(0),
    Levels(1),


    types(),
    MyProfileScreen(),

  ];

  @override
  _typesState createState() => _typesState();
}

class _typesState extends State<types> {
bool _video_1st=true;
  //bool _video_1st=false;

  bool _audio_1st=false;
//  bool _audio_1st=true;

 bool _text_1st=false;
 // bool _text_1st=true;


  bool _image_1st=false;
// bool _image_1st=true;



 @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 30,

          title: Text(

              "Learning Type"
          ),
          leading: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> Levels(1)));
             // _selectedIndex-=2;

            },),

        ),

      body: Center(
            child: Container(
              color: Colors.blue[200],
             // height: double.infinity,
            //  height: 620,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => {print("'Clicked'")},
                      child: Container(
                        width: 250,
                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image(

                              image: _video_1st?AssetImage('proj_images/video.png'):_audio_1st?AssetImage('proj_images/audio.png'):_image_1st?AssetImage('proj_images/image.png'):AssetImage('proj_images/Text.png'),
                              height: 250,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: Colors.black.withOpacity(.7),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 10.0),

                              child: Text(
                                 _video_1st?"Video":
                                 _audio_1st?'Audio':
                                 _image_1st?'Image':
                                 'Text',


                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                      Padding(
                        padding: const EdgeInsets.symmetric( vertical: 30),
                        child: Row(children: [
                          Spacer(),
                            GestureDetector(
                              onTap: () => {

                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => audio_player()),
                              ),
                            },
                                //print("'Clicked'")},
                              child: Container(
                             //   height: 100,

                                width: 120,
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Image(

                                      image:
                                      _video_1st?AssetImage('proj_images/audio.png'):
                                      _audio_1st?AssetImage('proj_images/video.png'):
                                      _image_1st?AssetImage('proj_images/video.png'):
                                      AssetImage('proj_images/video.png'),
                                      height: 110,


                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(.7),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        _video_1st?"Audio":
                                        _audio_1st?'Video':
                                        _image_1st?'Video':
                                        'Video',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Spacer(),
                            //////////////////////////////////////////////////////////////////////
                            GestureDetector(
                              onTap: () => {print("'Clicked'"),

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => image_view()),
                                ),


                              },
                              child: Container(
                              //  padding: EdgeInsets.only(top: 10.0),
                                width: 120,
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Image(
                                      image:
                                      _video_1st?AssetImage('proj_images/image.png'):
                                      _audio_1st?AssetImage('proj_images/image.png'):
                                      _image_1st?AssetImage('proj_images/audio.png'):
                                      AssetImage('proj_images/audio.png'),
                                   //   height: 250,
                                    //  width: 250,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(.7),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        _video_1st?"Image":
                                        _audio_1st?'Image':
                                        _image_1st?'Audio':
                                        'Audio',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Spacer(),

                            ///////////////////////////////////////////////////////
                            GestureDetector(
                              onTap: () => {

                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => pdf_view()),
                              ),
                                },
                              child: Container(
                              //  padding: EdgeInsets.only(top: 10.0),
                                width: 120,
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Image(
                                      image:
                                      _video_1st?AssetImage('proj_images/Text.png'):
                                      _audio_1st?AssetImage('proj_images/Text.png'):
                                      _image_1st?AssetImage('proj_images/Text.png'):
                                      AssetImage('proj_images/image.png'),
                                      height: 110,
                                      // height: 250,
                                  //    width: 250,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(.7),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        _video_1st?"Text":
                                        _audio_1st?'Text':
                                        _image_1st?'Text':
                                        'Image',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Spacer(),
                          ],),

                      ),
                    //),

                  ],
                ),
              ),
            ),
          )
      //),
    );
  }
}