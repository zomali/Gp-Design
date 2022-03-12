import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  static final  String BASE_URL = 'https://firebasestorage.googleapis.com/v0/b/graduation-project-a9cdf.appspot.com/o/2D%20Arrays%2FEnglish%2F2D%20Arrays.pdf?alt=media&token=3ff61101-9c37-41c1-9092-1aeeba7962f8';

  static Future<String> loadPDF() async {
    var response = await http.get(Uri.parse(BASE_URL));

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
