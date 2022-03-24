import 'package:firebase_database/firebase_database.dart';
import 'package:gp/classes/student.dart';
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

  Future<Topic_> getTopicData(int topicID) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('topics').child(topicID.toString()).get();
    var values = response.value; 
    Topic_ topic = Topic_();
    //get name
    topic.name = values['name'];
    //get audios
    topic.audios = <Audio_>[];
    var audios = values['audio'].keys;
    for(var language in audios)
    {
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
    for(var language in videos)
    {
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
    for(var image in images)
    {
      if(image == null)
      continue;
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
    for(var url in urls)
    {
      if(url == null)
      continue;
      URL_ u = URL_();
      u.url = url['url'];
      u.language = url['language'];
      u.source = url['source'];
      u.title = url['title'];
      topic.urls.add(u);
    }
    //get pdf
    Text_ t= Text_();
    t.language = 'English';
    t.URL = values['text']['English']['text'];
    t.source = values['text']['English']['source'];
    t.title = values['text']['English']['title'];
    return topic;
  }


 Future<Level_> getLevelData(int levelID) async{
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('levels').child(levelID.toString()).get();
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
    for(var topic in topics)
    {
      if(topic == null)
      continue;
      Topic_ t = Topic_();
      t.id = topic['topic_id'];
      t.name = topic['topic_name'];
      level.topics.add(t);
    }
    return level;
}


}
