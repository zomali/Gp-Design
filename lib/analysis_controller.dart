import 'dart:ffi';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

class Student_perf  {

  int NoOfCluster =0;
  int IndexInCluster =0;
  double ValueOfPerformance =0.0;

}
class analysis_controller {
  Future<Student_perf> cluster_performence( String idd ) async {
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
    double diss1 , diss2 ,diss3;
    List<String> cluster1 = [];
    List<String> cluster2 = [];
    List<String> cluster3 = [];
    List<double> cluster11 = [];
    List<double> cluster22 = [];
    List<double> cluster33 = [];
    List<double> cluster111 = [];
    List<double> cluster222 = [];
    List<double> cluster333 = [];

    bool x =true;
      while(x) {
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
          diss1=0;
          diss2=0;
          diss3=0 ;
        }
        for(var l in cluster11)
          pnt1+=l;
        pnt1 = pnt1/cluster11.length;

        for(var l in cluster11)
          pnt2+=l;

        pnt2 = pnt2/cluster22.length;

        for(var l in cluster11)
          pnt3+=l;

        pnt3 = pnt3/cluster33.length;

        if(cluster333 == cluster33 && cluster222 == cluster22 && cluster111 == cluster11)
          {

            break ;

          }
        else{
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
    print(cluster33);
    print(cluster3);
    print("-------------------------------------------------------");
    String id = idd;
    int ind =0;
    int noOfCluster = 0 ;
    if(cluster1.contains(id)) {
     ind = cluster1.indexOf(id);
     noOfCluster =1;
    }
    else if(cluster2.contains(id)) {
      ind = cluster2.indexOf(id);
      noOfCluster=2;
    }
       else if(cluster3.contains(id)) {
      ind = cluster3.indexOf(id);
      noOfCluster = 3;
    }
       if(noOfCluster ==1)
         {
           print(noOfCluster);
           print(ind);
           print(cluster11[ind]);
           std.NoOfCluster = noOfCluster;
           std.IndexInCluster = ind;
           std.ValueOfPerformance = cluster11[ind];
         }

    if(noOfCluster ==2)
    {
      print(noOfCluster);
      print(ind);
      print(cluster22[ind]);
      std.NoOfCluster = noOfCluster;
      std.IndexInCluster = ind;
      std.ValueOfPerformance = cluster22[ind];
    }

    if(noOfCluster ==3)
    {
      print(noOfCluster);
      print(ind);
      print(cluster33[ind]);
      std.NoOfCluster = noOfCluster;
      std.IndexInCluster = ind;
      std.ValueOfPerformance = cluster33[ind];
    }


return std;
  }

  void collebretive_filtering(String id) async {
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
  }
}
