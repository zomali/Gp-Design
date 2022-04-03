import 'package:flutter/material.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:gp/classes/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';
class image_view extends StatefulWidget {
  final student std;
  final ForImage forImage;
  final List<Image_> image_;
  image_view(this.std, this.image_, this.forImage);
  @override
  State<StatefulWidget> createState() {
    return new _image_view(std, image_, forImage);
  }
}
class _image_view extends State<image_view> {
  student std;
  ForImage forImage;
  List<Image_> image_;
  _image_view(this.std, this.image_, this.forImage);
  List<Container> _buildListItemsFromImages(){
    int index = 0;
    return image_.map((images){
      var container = Container(
        decoration: index % 2 == 0?
        new BoxDecoration(color: Colors.blue[900]):
        new BoxDecoration(
            color: Colors.blue[900],
        ),
        child: new Row(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.all(1.0),
              padding: const EdgeInsets.all(5.0),
              child: new CachedNetworkImage(
                imageUrl: images.URL,
                width: 370.0,
                height: 230.0,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      );
      index = index + 1;
      return container;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: _buildListItemsFromImages(),
    );
  }
}