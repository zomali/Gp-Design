class studentBehavior {
  ForAudio forAudio = ForAudio();
  ForImage forImage = ForImage();
  ForVideo forVideo = ForVideo();
  ForText forText = ForText();
  late String last_time_entered;
}

class ForVideo {
  var NumberOfVisitedPage;
  var TimeSpendInPage;
  var PopUpQuastion;
  var Time_progress_ratio;
  var Time_spent_every_once;

  var prefrence_weight;
}

class ForImage {
  var NumberOfVisitedPage;
  var TimeSpendInPage;
  var PopUpQuastion;
  var Time_progress_ratio;
  var Time_spent_every_once;

  var prefrence_weight;
}

class ForText {
  var NumberOfVisitedPage;
  var TimeSpendInPage;
  var PopUpQuastion;
  var Time_progress_ratio;
  var Time_spent_every_once;

  var prefrence_weight;
}

class ForAudio {
  var NumberOfVisitedPage;
  var TimeSpendInPage;
  var PopUpQuastion;
  var Time_progress_ratio;
  var Time_spent_every_once;

  var prefrence_weight;
}

class TypesForStudent {
  var audio;
  var text;
  var video;
  var image;


}

class TimeSpentEveryOnce {
  var listOfTime;
}
