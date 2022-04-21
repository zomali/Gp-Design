import 'package:firebase_database/firebase_database.dart';
import 'package:gp/classes/student.dart';
import 'package:gp/classes/studentBehavior.dart';
import 'package:gp/classes/classes.dart';

class DatabaseManager {
  Future<Course_> getCourseData(String courseCode) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('courses').child(courseCode).get();
    //var keys = response.value.keys;
    var values = response.value;
    Course_ c = new Course_();
    //get name and code
    c.code = courseCode;
    c.name = values['name'];
    //get learning outcomes
    c.learning_outcomes = <String>[];
    var outcomes = values['learning_outcomes'];
    for(var outcome in outcomes)
    {
      if(outcome == null)
      continue;
      String o = outcome['outcome'];
      c.learning_outcomes.add(o);
    }//get instructors
    c.instructors = <Instructor_>[];
    var instructors = values['instructors'];
    for (var instructor in instructors) {
      if(instructor == null)
      continue;
      Instructor_ i = Instructor_();
      i.name = instructor['name'];
      i.contact = instructor['contact'];
      i.department = instructor['department'];
      c.instructors.add(i);
    }
    //get levels
    c.levels = <Level_>[];
    var levels = values['levels'];
    for (var level in levels) {
      if(level == null)
      continue;
      Level_ l = Level_();
      l.id = level['level_id'];
      l.name = level['level_name'];
/*      l.id = values['levels'][level]['level_id'];
      l.name = values['levels'][level]['level_name'];*/
      c.levels.add(l);
      

    
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
      std.level = values[key]['courses']['CSW150']['current_level'];
      std.current_topic = values[key]['courses']['CSW150']['current_topic'];
      std.birthdate = values[key]['date_of_birth'];
      std.courses = values[key]['courses'];
      std.profile_picture = values[key]['profile_picture'];
      list.add(std);
    }
    return list;
  }

  Future<List<int>> getTimeTokenForEachLevel(student std) async {
    List<int> arr = [];
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase
        .child('student_behavior_model')
        .child(std.id)
        .get();
    //var keys = response.value.keys;
    var values = response.value;
    int type = 1;
    int topic = 3;
    for (int Level = 1; Level < 6; Level++) {
      var time = 0;
      if (Level > std.level) {
        arr.add(0);
      } else {
        int startTopic = 0;
        if (Level == 1) {
          startTopic = 1;
        } else if (Level == 2) {
          startTopic = 4;
          topic += 3;
        } else if (Level == 3) {
          startTopic = 7;
          topic += 4;
        } else if (Level == 4) {
          startTopic = 11;
          topic += 3;
        } else if (Level == 5) {
          startTopic = 14;
          topic += 4;
        }
        //print(values[1][1]['audio']['time_spent']);
        for (int t = startTopic; t <= topic; t++) {
          time += values[Level][t]['audio']['time_spent'] as int;
          time += values[Level][t]['text']['time_spent'] as int;
          time += values[Level][t]['video']['time_spent'] as int;
          time += values[Level][t]['image']['time_spent'] as int;
        }
        //print(time);
        //time = time / 60 as int;
        int timeInMinetes = 0;
        if (time < 60) {
          timeInMinetes = 1;
        } else {
          while (time >= 60) {
            timeInMinetes++;
            time -= 60;
          }
        }
        arr.add(timeInMinetes);
        //print(time);
      }
    }
    return arr;
  }

  Future<Topic_> getTopicData(int topicID) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response =
        await firebaseDatabase.child('topics').child(topicID.toString()).get();
    var values = response.value;
    Topic_ topic = Topic_();
    //get name & ID
    topic.id = topicID;
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
    topic.pdf = t;

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
          'current_topic': 1,
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
    firebaseDatabase.child('student_behavior_model').child(std.id).set({
      '1': {
        '1': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '2': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '3': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        }
      },
      '2': {
        '4': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '5': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '6': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        }
      },
      '3': {
        '7': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '8': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '9': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '10': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        }
      },
      '4': {
        '11': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '12': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '13': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        }
      },
      '5': {
        '14': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '15': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '16': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        },
        '17': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'last_time_enterd': 'First Time',
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'last_time_enterd': 0,
            'time_spent': 0
          }
        }
      }
    });
  }

  Future<studentBehavior> fetchStudentBehavior(
      var id, var level, var topic) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase
        .child('student_behavior_model')
        .child(id.toString())
        .get();
    var value = response.value;
    studentBehavior std = studentBehavior();
    int startTopic = 0;
    if (level == 1) {
      startTopic = 1;
    } else if (level == 2) {
      startTopic = 4;
      topic += 3;
    } else if (level == 3) {
      startTopic = 7;
      topic += 6;
    } else if (level == 4) {
      startTopic = 11;
      topic += 10;
    } else if (level == 5) {
      startTopic = 14;
      topic += 13;
    }

    for (int i = 1; i <= level; i++) {
      for (int j = startTopic; j < topic; j++) {
        //for video
        std.forVideo.NumberOfVisitedPage +=
            value[i][j]['video']['number_of_visits'];
        std.forVideo.TimeSpendInPage += value[i][j]['video']['time_spent'];

        //for audio
        std.forAudio.NumberOfVisitedPage +=
            value[i][j]['audio']['number_of_visits'];
        std.forAudio.TimeSpendInPage += value[i][j]['audio']['time_spent'];

        //for Image
        std.forImage.NumberOfVisitedPage +=
            value[i][j]['image']['number_of_visits'];
        std.forImage.TimeSpendInPage += value[i][j]['image']['time_spent'];

        //for Text
        std.forText.NumberOfVisitedPage +=
            value[i][j]['text']['number_of_visits'];
        std.forText.TimeSpendInPage += value[i][j]['text']['time_spent'];
      }
    }

    return std;
  }

  Future<studentBehavior> fetchTimeSpendEveryOnce(
      var id, var level, var topic) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase
        .child('student_behavior_model')
        .child(id.toString())
        .child(level.toString())
        .child(topic.toString())
        .get();
    var value = response.value;
    studentBehavior std = studentBehavior();

    std.last_time_entered = value['last_time_enterd'];

    std.forAudio.NumberOfVisitedPage = value['audio']['number_of_visits'];
    std.forAudio.PopUpQuastion = value['audio']['popUpQuestion'];
    std.forAudio.TimeSpendInPage = value['audio']['time_spent'];
    std.forAudio.Time_progress_ratio = value['audio']['Time_progress_ratio'];
    std.forAudio.Time_spent_every_once =
        value['audio']['time_spent_every_once'];

    std.forImage.NumberOfVisitedPage = value['image']['number_of_visits'];
    std.forImage.PopUpQuastion = value['image']['popUpQuestion'];
    std.forImage.TimeSpendInPage = value['image']['time_spent'];
    std.forImage.Time_progress_ratio = value['image']['Time_progress_ratio'];
    std.forImage.Time_spent_every_once =
        value['image']['time_spent_every_once'];

    std.forText.NumberOfVisitedPage = value['text']['number_of_visits'];
    std.forText.PopUpQuastion = value['text']['popUpQuestion'];
    std.forText.TimeSpendInPage = value['text']['time_spent'];
    std.forText.Time_progress_ratio = value['text']['Time_progress_ratio'];
    std.forText.Time_spent_every_once = value['text']['time_spent_every_once'];

    std.forVideo.NumberOfVisitedPage = value['video']['number_of_visits'];
    std.forVideo.PopUpQuastion = value['video']['popUpQuestion'];
    std.forVideo.TimeSpendInPage = value['video']['time_spent'];
    std.forVideo.Time_progress_ratio = value['video']['Time_progress_ratio'];
    std.forVideo.Time_spent_every_once =
        value['video']['time_spent_every_once'];
    return std;
  }

  void updateStudentBehavior(int time, int clicks, String type, var id,
      var Level, var Topic, var arr, var last_time) {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    firebaseDatabase
        .child('student_behavior_model')
        .child(id.toString())
        .child(Level.toString())
        .child(Topic.toString())
        .child(type)
        .update({
      'number_of_visits': clicks,
      'time_spent': time,
      'last_time_enterd': last_time,
      'time_spent_every_once': arr
    });

    firebaseDatabase
        .child('student_behavior_model')
        .child(id.toString())
        .child(Level.toString())
        .child(Topic.toString())
        .update({'last_time_enterd': last_time});
  }

  void update1() {
    List<int> arr = [];
    arr.add(0);
    arr.add(3);

    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    firebaseDatabase
        .child('student_behavior_model')
        .child('2018170065')
        .child('1')
        .child('1')
        .child('audio')
        .set({
      'number_of_visits': 0,
      'popUpQuestion': {'qID': 'answerID'},
      'time_spent_every_once': arr,
      'time_progress_ratio': 0,
      'time_spent': 0
    });
  }

  void updateStudentBehavior1() {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    firebaseDatabase
        .child('student_behavior_model')
        .child('2018170135')
        .update({
      '1': {
        '1': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '2': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '3': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        }
      },
      '2': {
        '4': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '5': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '6': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        }
      },
      '3': {
        '7': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '8': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '9': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '10': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        }
      },
      '4': {
        '11': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '12': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '13': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        }
      },
      '5': {
        '14': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '15': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '16': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        },
        '17': {
          'audio': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'image': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'text': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          },
          'video': {
            'number_of_visits': 0,
            'popUpQuestion': {'qID': 'answerID'},
            'time_spent_every_once': {'1': 0},
            'time_progress_ratio': 0,
            'time_spent': 0
          }
        }
      }
    });
  }

  void update() {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    firebaseDatabase
        .child('student_behavior_model')
        .child('2018170064')
        .child('1')
        .child('3')
        .update({
      'last_time_enterd': 'First Time',
    });
  }

  Future<List<int>> fetchAllStudentGrades(student std) async {
    List<int> arr = [];
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('students').get();
    var keys = response.value.keys;
    var values = response.value;
    List<int> length = [];
    length.add(0);
    length.add(0);
    length.add(0);
    length.add(0);
    length.add(0);
    arr.add(0);
    arr.add(0);
    arr.add(0);
    arr.add(0);
    arr.add(0);
    for (var key in keys) {
      for (int i = 0; i < 5; i++) {
        if (values[key]['courses']['CSW150']['quizes'][i] == 0) {
          continue;
        } else {
          length[i]++;
        }
      }
    }
    for (var key in keys) {
      if (key == std.id) {
        continue;
      } else {
        for (int i = 0; i < 5; i++) {
          arr[i] += values[key]['courses']['CSW150']['quizes'][i] as int;
        }
      }
    }
    for (int i = 0; i < 5; i++) {
      arr[i] = (arr[i] / (length[i] - 1)).round();
    }
    return arr;
  }

  Future<List<int>> fetchStudentGrades(student std) async {
    List<int> arr = [];
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase
        .child('students')
        .child(std.id)
        .child('courses')
        .child('CSW150')
        .child('quizes')
        .get();
    for (int i = 0; i < 5; i++) {
      arr.add(response.value[i]);
    }
    return arr;
  }

  Future<List<int>> getTimeTokenForEachLevelForAllStudents(student std) async {
    List<int> arr = [];
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response =
        await firebaseDatabase.child('student_behavior_model').get();
    var keys = response.value.keys;
    var values = response.value;
    int length = 0;
    arr.add(0);
    arr.add(0);
    arr.add(0);
    arr.add(0);
    arr.add(0);
    for (var key in keys) {
      length++;
    }
    for (var key in keys) {
      if (key == std.id) {
        continue;
      } else {
        int type = 1;
        int topic = 3;
        for (int Level = 1; Level < 6; Level++) {
          var time = 0;
          int startTopic = 0;
          if (Level == 1) {
            startTopic = 1;
          } else if (Level == 2) {
            startTopic = 4;
            topic += 3;
          } else if (Level == 3) {
            startTopic = 7;
            topic += 4;
          } else if (Level == 4) {
            startTopic = 11;
            topic += 3;
          } else if (Level == 5) {
            startTopic = 14;
            topic += 4;
          }
          //print(values[1][1]['audio']['time_spent']);
          if (Level == 1) {
            for (int t = startTopic; t <= topic; t++) {
              arr[Level - 1] +=
                  values[key][Level][t]['audio']['time_spent'] as int;
              arr[Level - 1] +=
                  values[key][Level][t]['text']['time_spent'] as int;
              arr[Level - 1] +=
                  values[key][Level][t]['video']['time_spent'] as int;
              arr[Level - 1] +=
                  values[key][Level][t]['image']['time_spent'] as int;
            }
          } else {
            for (int t = startTopic; t <= topic; t++) {
              arr[Level - 1] += values[key][Level][t.toString()]['audio']
                  ['time_spent'] as int;
              arr[Level - 1] +=
                  values[key][Level][t.toString()]['text']['time_spent'] as int;
              arr[Level - 1] += values[key][Level][t.toString()]['video']
                  ['time_spent'] as int;
              arr[Level - 1] += values[key][Level][t.toString()]['image']
                  ['time_spent'] as int;
            }
          }
        }
      }
    }
    List<int> times = [];
    for (int i = 0; i < 5; i++) {
      double average = arr[i] / (length - 1);
      int timeInMinetes = 0;
      if (average < 60 && average > 0) {
        timeInMinetes = 1;
      } else {
        while (average >= 60) {
          timeInMinetes++;
          average -= 60;
        }
      }
      times.add(timeInMinetes);
    }
    return times;
  }

  void update2() {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    firebaseDatabase
        .child('students')
        .child('2018170064')
        .child('courses')
        .child('CSW150')
        .update({
      'current_topic': 2,
    });
  }

  Future<String> getCurrentTopicPercet(student std) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase
        .child('students')
        .child(std.id)
        .child('courses')
        .child('CSW150')
        .get();
    if (response.value['current_topic'] == 17) {
      String per = "100";
      return per;
    } else {
      double percent = response.value['current_topic'] * 5.8;
      String per = percent.toString();
      return per;
    }
  }
}
