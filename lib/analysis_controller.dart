import 'dart:ffi';
import 'dart:math';
import 'package:gp/DatabaseManager.dart';
import 'package:gp/classes/student.dart';
import 'package:firebase_database/firebase_database.dart';

class Student_perf {
  int NoOfCluster = 0;
  int IndexInCluster = 0;
  double ValueOfPerformance = 0.0;
  List<String> UserIds = [];
  List<double> UsersGrades = [];
  int lengthOfCluster =0;
  String typeOfStudentCluster = "";
  String typeOfCluster1 = "";
  String typeOfCluster2="";
  String typeOfCluster3 = "";
}

class analysis_controller {
  Future<Student_perf> cluster_performence(String idd) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('quizzes').get();
    var keys = response.value.keys;
    var values = response.value;
    var levels = [];
    var Tobics = [];
    List<String> IDs = [];
    List<double> Grades = [];
    List<double> TotalGrades = [];
    Student_perf std = new Student_perf();

    for (var key in keys) {
      IDs.add(key);
      levels.add(values[key]['Level']);
      Tobics.add(values[key]['Topic']);
      print(key);
    }
    double grade = 0;
    double total = 0;
    for (var lev in levels) {
      if (lev != null) {
        for (var k in lev.keys) {
          grade += lev[k]["student_score"];
          total += lev[k]["total_score"];
        }
      }
      Grades.add(grade);
      TotalGrades.add(total);
      total = 0;
      grade = 0;
    }
    int index = 0;
    for (var lev in Tobics) {
      if (lev != null) {
        for (var k in lev.keys) {
          grade += lev[k]["student_score"];
          total += lev[k]["total_score"];
        }
      }
      Grades[index] += grade;
      TotalGrades[index] += total;
      TotalGrades[index] = (Grades[index] / TotalGrades[index]) * 100;
      total = 0;
      grade = 0;
      index++;
    }

    print(TotalGrades);

    double pnt1 = TotalGrades[0];
    double pnt2 = TotalGrades[1];
    double pnt3 = TotalGrades[2];
    double diss1, diss2, diss3;
    List<String> cluster1 = [];
    List<String> cluster2 = [];
    List<String> cluster3 = [];
    List<double> cluster11 = [];
    List<double> cluster22 = [];
    List<double> cluster33 = [];
    List<double> cluster111 = [];
    List<double> cluster222 = [];
    List<double> cluster333 = [];
    String typeOfCluster1 = "";
    String typeOfCluster2="";
    String typeOfCluster3 = "";


    bool x = true;
    while (x) {
      for (int i = 0; i < TotalGrades.length; i++) {
        diss1 = TotalGrades[i] - pnt1;
        diss1 = diss1.abs();
        diss2 = TotalGrades[i] - pnt2;
        diss2 = diss2.abs();
        diss3 = TotalGrades[i] - pnt3;
        diss3 = diss3.abs();

        if (diss1 > diss2) {
          if (diss2 < diss3) {
            cluster2.add(IDs[i]);
            cluster22.add(TotalGrades[i]);
          }
        }
        if (diss2 > diss1) {
          if (diss1 < diss3) {
            cluster1.add(IDs[i]);
            cluster11.add(TotalGrades[i]);
          }
        }
        if (diss1 > diss3) {
          if (diss3 < diss2) {
            cluster3.add(IDs[i]);
            cluster33.add(TotalGrades[i]);
          }
        }
        diss1 = 0;
        diss2 = 0;
        diss3 = 0;
      }
      for (var l in cluster11) pnt1 += l;
      pnt1 = pnt1 / cluster11.length;

      for (var l in cluster11) pnt2 += l;

      pnt2 = pnt2 / cluster22.length;

      for (var l in cluster11) pnt3 += l;

      pnt3 = pnt3 / cluster33.length;

      if (cluster333 == cluster33 &&
          cluster222 == cluster22 &&
          cluster111 == cluster11) {
        break;
      } else {
        cluster333 = cluster33;
        cluster222 = cluster22;
        cluster111 = cluster11;
        cluster11.clear();
        cluster22.clear();
        cluster33.clear();
        cluster1.clear();
        cluster2.clear();
        cluster3.clear();
      }
    }
    print("Cluster content");
    if(cluster11[0]>50)
    typeOfCluster1 ="Fail";
    else if(cluster11[0]>65)
       typeOfCluster1 ="Good";
    else if(cluster11[0]>85)
      typeOfCluster1 ="Excellent";
    ////////////////////////////////////////////////
    if(cluster22[0]>50)
      typeOfCluster1 ="Fail";
    else if(cluster22[0]>65)
      typeOfCluster1 ="Good";
    else if(cluster22[0]>85)
      typeOfCluster1 ="Excellent";
    //////////////////////////////////////////////////
    if(cluster33[0]>50)
      typeOfCluster1 ="Fail";
    else if(cluster33[0]>65)
      typeOfCluster1 ="Good";
    else if(cluster33[0]>85)
      typeOfCluster1 ="Excellent";


    print(cluster33);
    print(cluster3);
    print("-------------------------------------------------------");
    String id = idd;
    int ind = 0;
    int noOfCluster = 0;
    if (cluster1.contains(id)) {
      ind = cluster1.indexOf(id);
      noOfCluster = 1;
    } else if (cluster2.contains(id)) {
      ind = cluster2.indexOf(id);
      noOfCluster = 2;
    } else if (cluster3.contains(id)) {
      ind = cluster3.indexOf(id);
      noOfCluster = 3;
    }
    if (noOfCluster == 1) {
      print(noOfCluster);
      print(ind);
      print(cluster11[ind]);
      std.NoOfCluster = noOfCluster;
      std.IndexInCluster = ind;
      std.ValueOfPerformance = cluster11[ind];
      std.UserIds = cluster1;
      std.UsersGrades = cluster11;
      std.typeOfStudentCluster =  typeOfCluster1;
      std.lengthOfCluster = cluster11.length;
    }

    if (noOfCluster == 2) {
      print(noOfCluster);
      print(ind);
      print(cluster22[ind]);
      std.NoOfCluster = noOfCluster;
      std.IndexInCluster = ind;
      std.ValueOfPerformance = cluster22[ind];
      std.UserIds = cluster2;
      std.UsersGrades = cluster22;
      std.typeOfStudentCluster =  typeOfCluster2;
      std.lengthOfCluster = cluster22.length;
    }

    if (noOfCluster == 3) {
      print(noOfCluster);
      print(ind);
      print(cluster33[ind]);
      std.NoOfCluster = noOfCluster;
      std.IndexInCluster = ind;
      std.ValueOfPerformance = cluster33[ind];
      std.UserIds = cluster3;
      std.UsersGrades = cluster33;
      std.typeOfStudentCluster =  typeOfCluster3;
      std.lengthOfCluster = cluster33.length;
    }
    //return
    // rakam el cluster bta3 el student
    // el index bta3oh gwa el cluster
    // el draga bta3to fe el performance
    // el ID bta3 kol el cluster bta3o (rakam el gloos)
    // el daragat bta3t kol el cluster
    // no3 el cluster (type bta3 el cluster shater wla la2)
    // 3dd kol el fe el cluster
    // typess kol el clusters

      std.typeOfCluster1=typeOfCluster1;
      std.typeOfCluster2 = typeOfCluster2;
      std.typeOfCluster3 = typeOfCluster3;
    return std;
  }

  Future<List<double>> collaborative_filtering(
      String id, String LevelID, String TopicID) async {
    DatabaseReference firebaseDatabase = FirebaseDatabase.instance.reference();
    final response = await firebaseDatabase.child('quizzes').get();
    var keys = response.value.keys;
    var values = response.value;
    var levels = [];
    var Tobics = [];
    double UserGrade = 0;
    double UserTotalGrades = 0;
    List<String> IDs = [];
    List<double> Grades = [];
    List<double> TotalGrades = [];
    List<double> distence = [];
    for (var key in keys) {
      if (key.toString() == id) {
        continue;
      } else {
        IDs.add(key);
        levels.add(values[key]['Level']);
        Tobics.add(values[key]['Topic']);
        print(key);
      }
    }
    double grade = 0;
    double total = 0;
    for (var lev in levels) {
      if (lev != null) {
        for (var k in lev.keys) {
          grade += lev[k]["student_score"];
          total += lev[k]["total_score"];
        }
      }
      Grades.add(grade);
      TotalGrades.add(total);
      total = 0;
      grade = 0;
    }

    int eachStudent = 0;
    for (var tob in Tobics) {
      if (tob != null) {
        for (var k in tob.keys) {
          grade += tob[k]["student_score"];
          total += tob[k]["total_score"];
        }
      }
      Grades[eachStudent] += grade;
      TotalGrades[eachStudent] += total;
      TotalGrades[eachStudent] =
          (Grades[eachStudent] / TotalGrades[eachStudent]) * 100;
      total = 0;
      grade = 0;
      eachStudent++;
    }
    //print(TotalGrades[3]);

    if (values[id]['Level'] != null) {
      for (var k in values[id]['Level'].keys) {
        UserGrade += values[id]['Level'][k]["student_score"];
        UserTotalGrades += values[id]['Level'][k]["total_score"];
      }
    }
    if (values[id]['Topic'] != null) {
      for (var k in values[id]['Topic'].keys) {
        UserGrade += values[id]['Topic'][k]["student_score"];
        UserTotalGrades += values[id]['Topic'][k]["total_score"];
      }
    }
    UserTotalGrades = (UserGrade / UserTotalGrades) * 100;
    print(UserTotalGrades);
    double dis = 0;
    for (var t in TotalGrades) {
      dis = UserTotalGrades - t;
      dis *= dis;
      distence.add(dis);
    }
    int index = 0;
    double weight = distence[0];
    for (int i = 1; i < distence.length; i++) {
      if (distence[i] < weight) {
        weight = distence[i];
        index = i;
      }
    }
    String RelativeUserID = IDs[index];
    print(RelativeUserID);
    final response1 = await firebaseDatabase
        .child('student_behavior_model')
        .child(RelativeUserID)
        .child(LevelID)
        .child(TopicID)
        .get();
    var Keys = response1.value.keys;
    var Values = response1.value;
    int audioTime = Values["audio"]["time_spent"];
    int VideoTime = Values["video"]["time_spent"];
    int textTime = Values["text"]["time_spent"];
    int imageTime = Values["image"]["time_spent"];
    List<double> TimeWeight = [];
    if (VideoTime > audioTime &&
        VideoTime > textTime &&
        VideoTime > imageTime) {
      TimeWeight.add(1000);
      TimeWeight.add(0);
      TimeWeight.add(0);
      TimeWeight.add(0);
    } else if (audioTime > VideoTime &&
        audioTime > textTime &&
        audioTime > imageTime) {
      TimeWeight.add(0);
      TimeWeight.add(1000);
      TimeWeight.add(0);
      TimeWeight.add(0);
    } else if (imageTime > VideoTime &&
        imageTime > textTime &&
        imageTime > audioTime) {
      TimeWeight.add(0);
      TimeWeight.add(0);
      TimeWeight.add(1000);
      TimeWeight.add(0);
    } else {
      TimeWeight.add(0);
      TimeWeight.add(0);
      TimeWeight.add(0);
      TimeWeight.add(1000);
    }
    return TimeWeight;
  }

  bool compare_centroids(
      Map<String, String> new_centroids, Map<String, String> old_centroids) {
    bool different_centroids = false;

    for (var centroid in new_centroids.keys) {
      if (!old_centroids.containsKey(centroid)) {
        different_centroids = true;
        break;
      }
    }
    return different_centroids;
  }

  Map<String, String> calculate_centroids(Map<String, String> centroids,
      Map<String, String> student_cluster, Map<String, String> student_VAR) {
    Map<String, String> new_centroids = {};
    for (var centroid in centroids.keys) {
      int totalV = 0;
      int totalA = 0;
      int totalR = 0;
      int totalStudents = 0;
      for (var student in student_cluster.keys) {
        if (student_cluster[student] == centroid) {
          List<String> VAR = student_VAR[student]!.split(",");
          totalV += int.parse(VAR[0]);
          totalA += int.parse(VAR[1]);
          totalR += int.parse(VAR[2]);
          totalStudents += 1;
        }
      }
      new_centroids[centroid] = (totalV / totalStudents).toString() +
          ',' +
          (totalA / totalStudents).toString() +
          ',' +
          (totalR / totalStudents).toString();
    }
    return new_centroids;
  }

  Future<List<String>> cluster_students_by_behavior(int k, student std) async {
    //get average time spent in each content type
    DatabaseManager db = DatabaseManager();
    List<student> students = await db.fetchStudents();

    //prepare data points
    Map<String, String> student_VAR = {}; //ID:'V,A,R/W'
    for (var std in students) {
      int V =
          await db.getTimeTokenInVideo(std) + await db.getTimeTokenInImage(std);
      int A = await db.getTimeTokenInAudio(std);
      int R = await db.getTimeTokenInText(std);
      student_VAR[std.id] = (V / std.current_topic).toString() +
          ',' +
          (A / std.current_topic).toString() +
          ',' +
          (R / std.current_topic).toString();
    }

    //select 3 random clusters
    Map<String, String> current_centroids = {};
    Map<String, String> new_centroids = {};
    new_centroids.addAll({
      '1': student_VAR[students[0].id]!,
      '2': student_VAR[students[1].id]!,
      '3': student_VAR[students[2].id]!
    });

    Map<String, String> student_cluster = {}; //ID:cluster
    do {
      student_cluster.clear();
      current_centroids.clear();
      current_centroids.addAll(new_centroids);
      //assign the student to the clusters
      for (var student in student_VAR.keys) {
        List<String> V_A_Rs = student_VAR[student]!.split(',');
        Map<String, double> distance = {};
        for (var centroid in current_centroids.keys) {
          List<String> V_A_Rc = current_centroids[centroid]!.split(',');
          //sqr((Vc-Vs)^2+(Ac-As)^2+(Rc-Rs)^2)
          distance[centroid] = sqrt(
              pow(int.parse(V_A_Rc[0]) - int.parse(V_A_Rs[0]), 2) +
                  pow(int.parse(V_A_Rc[1]) - int.parse(V_A_Rs[1]), 2) +
                  pow(int.parse(V_A_Rc[2]) - int.parse(V_A_Rs[2]), 2));
        }
        double min_dist = -1;
        String min_cent = "";
        for (var cent in distance.keys) {
          if (distance[cent]! < min_dist) {
            min_dist = distance[cent]!;
            min_cent = cent;
          }
        }
        student_cluster[student] = min_cent;
      }
      //re-calculate centroids
      new_centroids =
          calculate_centroids(current_centroids, student_cluster, student_VAR);
    } while (compare_centroids(new_centroids, current_centroids));

    List<String> similar_students = [];
    String sCent = student_cluster[std.id]!;
    for(var s in student_cluster.keys)
    {
      if(student_cluster[s]! == sCent)
      {
        similar_students.add(s);
      }
    }
    return similar_students;
  }
}
