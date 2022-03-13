import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gp/images_data.dart';
class image_view extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new _image_view();
  }
}
class _image_view extends State<image_view> {
  List<Container> _buildListItemsFromImages(){
    int index = 0;
    return Images.map((images){
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
                imageUrl: images.imageURL,
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