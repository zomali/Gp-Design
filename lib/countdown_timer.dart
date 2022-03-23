import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class countdown extends AnimatedWidget
{

  countdown({ Key? key, required this.animation}):
      super(key: key,listenable: animation);
  Animation<int> animation;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Duration clocktimer=Duration(seconds: animation.value);
    var timertext='${clocktimer.inMinutes.remainder(60).toString()}:';
        timertext+='${(clocktimer.inSeconds.remainder(60)%60).toString().padLeft(2,'0')}';
    return Text('${timertext}',style: TextStyle(fontSize: 40,color: Theme.of(context).primaryColor),);
  }

}