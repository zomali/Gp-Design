import 'package:flutter/material.dart';

class infoDialog extends StatelessWidget {
String? title, description, buttonText;

infoDialog({
  @required this.title,
  @required this.description,
  @required this.buttonText,
});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: 16.0,
          right:16.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 3, 60, 126),
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.0,),
            Text(
              description!,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height:24.0 ,),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  buttonText!,
                  style: TextStyle(
                    color: Color.fromARGB(255, 3, 60, 126),
                  ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}