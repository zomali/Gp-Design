import 'package:flutter/material.dart';
class Menu_SideBar extends StatelessWidget {
final IconData?icon;
final String?title;
final Color?iconColor;
final Color?titleColor;

  const Menu_SideBar({Key? key, this.icon, this.title, this.iconColor, this.titleColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Padding(
          padding:  const EdgeInsets.all(16),
        child: Row(
          children: [

            Icon(icon,
            color: iconColor,
              size: 30,
            ),
            SizedBox(width: 20,),
            Text(title!,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 26,color: titleColor),
            ),
          ],

        ),


      ),
    );
  }
}
