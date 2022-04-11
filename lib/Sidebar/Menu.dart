import 'package:flutter/material.dart';
class Menu_SideBar extends StatelessWidget {
final IconData?icon;
final String?title;
//final Function ontap;
const Menu_SideBar({Key? key, this.icon, this.title,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: ontap!(),
      child: Padding(
          padding:  const EdgeInsets.all(16),
        child: Row(
          children: [

            Icon(icon,
            color: Colors.cyan,
              size: 30,
            ),
            SizedBox(width: 20,),
            Text(title!,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 26,color: Colors.white),
            ),

          ],

        ),


      ),
    );
  }
}
