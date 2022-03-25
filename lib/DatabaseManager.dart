import 'package:firebase_database/firebase_database.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'classes/course.dart';
import 'package:gp/classes/classes.dart';

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
    for (var key in keys) {
      student std = student();
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

  Future<Topic_> getTopicData(int topicID) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response =
        await firebaseDatabase.child('topics').child(topicID.toString()).get();
    var values = response.value;
    Topic_ topic = Topic_();
    //get name
    topic.name = values['name'];
    //get audios
    topic.audios = <Audio_>[];
    var audios = values['audio'].keys;
    for (var language in audios) {
      Audio_ a = Audio_();
      a.language = language;
      a.URL = values['audio'][language]['audio'];
      a.duration = values['audio'][language]['duration'];
      a.source = values['audio'][language]['source'];
      a.title = values['audio'][language]['title'];
      topic.audios.add(a);
    }
    //get videos
    topic.videos = <Video_>[];
    var videos = values['video'].keys;
    for (var language in videos) {
      Video_ v = Video_();
      v.language = language;
      v.URL = values['video'][language]['video'];
      v.duration = values['video'][language]['duration'];
      v.source = values['video'][language]['source'];
      v.title = values['video'][language]['title'];
      topic.videos.add(v);
    }
    //get images
    topic.images = <Image_>[];
    var images = values['image'];
    for (var image in images) {
      if (image == null) continue;
      Image_ i = Image_();
      i.URL = image['image'];
      i.language = image['language'];
      i.source = image['source'];
      i.title = image['title'];
      topic.images.add(i);
    }
    //get urls
    topic.urls = <URL_>[];
    var urls = values['URL'];
    for (var url in urls) {
      if (url == null) continue;
      URL_ u = URL_();
      u.url = url['url'];
      u.language = url['language'];
      u.source = url['source'];
      u.title = url['title'];
      topic.urls.add(u);
    }
    //get pdf
    Text_ t = Text_();
    t.language = 'English';
    t.URL = values['text']['English']['text'];
    t.source = values['text']['English']['source'];
    t.title = values['text']['English']['title'];
    return topic;
  }

  Future<Level_> getLevelData(int levelID) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response =
        await firebaseDatabase.child('levels').child(levelID.toString()).get();
    Level_ level = Level_();
    var value = response.value;
    //get ID & name
    level.id = levelID;
    level.name = value['name'];
    //get topics data
    //retrieve only the name and id of topic
    //if this topic is selected to view them retieve it's info using the id & retrieveTopicData function
    level.topics = <Topic_>[];
    var topics = value['topics'];
    for (var topic in topics) {
      if (topic == null) continue;
      Topic_ t = Topic_();
      t.id = topic['topic_id'];
      t.name = topic['topic_name'];
      level.topics.add(t);
    }
    return level;
  }

  void insertNewStudent(student std) {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    firebaseDatabase.child('students').child(std.id).set({
      'courses': {
        'CSW150': {
          'current_level': 1,
          'quizes': {'1': 'level_id'},
          'topics_of_weakness': {'1': 'number_of_wrong_answered_questions'}
        }
      },
      'date_of_birth': std.birthdate,
      'email': std.email,
      'name': std.name,
      'password': std.password,
      'profile_picture': std.profile_picture //hint
    });
    firebaseDatabase
        .child('student_behavior_model')
        .child(std.id)
        .child('1')
        .set({
      'audio': {
        'content_progress': '60min',
        'number_of_visits': 0,
        'popUpQuestion': {'qID': 'answerID'},
        'time_progress_ratio': 0,
        'time_spent': 0
      },
      'image': {
        'content_progress': '/',
        'number_of_visits': 0,
        'popUpQuestion': {'qID': 'answerID'},
        'time_progress_ratio': 0,
        'time_spent': 0
      },
      'text': {
        'content_progress': '/',
        'number_of_visits': 0,
        'popUpQuestion': {'qID': 'answerID'},
        'time_progress_ratio': 0,
        'time_spent': 0
      },
      'video': {
        'content_progress': '/',
        'number_of_visits': 0,
        'popUpQuestion': {'qID': 'answerID'},
        'time_progress_ratio': 0,
        'time_spent': 0
      }
    });
  }

  Future<studentBehavior> fetchStudentBehavior(var id) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase
        .child('student_behavior_model')
        .child(id.toString())
        .child('1')
        .get();
    var value = response.value;
    studentBehavior std = studentBehavior();

    //for video
    std.forVideo.NumberOfVisitedPage = value['video']['number_of_visits'];
    std.forVideo.TimeSpendInPage = value['video']['time_spent'];

    //for audio
    std.forAudio.NumberOfVisitedPage = value['audio']['number_of_visits'];
    std.forAudio.TimeSpendInPage = value['audio']['time_spent'];

    //for Image
    std.forImage.NumberOfVisitedPage = value['image']['number_of_visits'];
    std.forImage.TimeSpendInPage = value['image']['time_spent'];

    //for Text
    std.forText.NumberOfVisitedPage = value['text']['number_of_visits'];
    std.forText.TimeSpendInPage = value['text']['time_spent'];

    return std;
  }

  void updateStudentBehavior(int time, int clicks, String type, var id) {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    firebaseDatabase
        .child('student_behavior_model')
        .child(id.toString())
        .child('1')
        .child(type)
        .update({'number_of_visits': clicks, 'time_spent': time});
  }

  // void update() {
  //   DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
  //   firebaseDatabase
  //       .child('student_behavior_model')
  //       .child('2018170076')
  //       .child('1')
  //       .child('audio')
  //       .update({'time_spent': 0});
  //   firebaseDatabase
  //       .child('student_behavior_model')
  //       .child('2018170076')
  //       .child('1')
  //       .child('image')
  //       .update({'time_spent': 0});
  //   firebaseDatabase
  //       .child('student_behavior_model')
  //       .child('2018170076')
  //       .child('1')
  //       .child('text')
  //       .update({'time_spent': 0});
  //   firebaseDatabase
  //       .child('student_behavior_model')
  //       .child('2018170076')
  //       .child('1')
  //       .child('video')
  //       .update({'time_spent': 0});
  // }
}
