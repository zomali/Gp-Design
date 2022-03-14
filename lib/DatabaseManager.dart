import 'package:firebase_database/firebase_database.dart';
import 'package:gp/classes/student.dart';
import 'classes/course.dart';

class DatabaseManager {
  Future<course> getCourses() async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('courses').get();
    var keys = response.value.keys;
    var values = response.value;
    course c = new course();
    for (var key in keys) {
      c.instructors = values[key]['instructors'];
      c.levels = values[key]['levels'];
      c.name = values[key]['name'];
      c.learning_outcomes = values[key]['learning_outcomes'];
      c.number_of_levels = values[key]['number_of_levels'];
    }
    return c;
  }

  Future<List<student>> fetchStudents() async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('students').get();
    var keys = response.value.keys;
    var values = response.value;
    List<student> list = [];
    student std = student();
    for (var key in keys) {
      std.id = key;
      std.name = values[key]['name'];
      std.email = values[key]['email'];
      std.password = values[key]['password'];
      std.level = values[key]['level'];
      std.birthdate = values[key]['date_of_birth'];
      std.courses = values[key]['courses'];
      std.profile_picture = values[key]['profile_picture'];
      list.add(std);
    }
    return list;
  }
}
