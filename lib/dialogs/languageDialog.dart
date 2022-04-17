import 'package:flutter/material.dart';

class languageDialog extends StatelessWidget {

  String? selectedLanguage;
  languageDialog({ @required this.selectedLanguage});
  @override
  Widget build(BuildContext context) {
    return Dialog(
          elevation: 0,
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            width: 500,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'proj_images/lan.png',
                    width: 90,
                    height: 90,
                  ),
                ),
                Text(
                  "Select Language",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Container(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            selectedLanguage = "Arabic";
                            Navigator.of(context).pop();
                          },
                          child: Text("Arabic",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                    ),
                    Container(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            selectedLanguage = "English";
                            Navigator.of(context).pop();
                          },
                          child: Text("English",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                    )
                  ],
                )
              ],
            ),
          ),
        );
  }
}