// ignore_for_file: non_constant_identifier_names, camel_case_types

class Audio_{
  late String language;
  late String URL;
  late String duration;
  late String source;
  late String title;
}
class Video_{
  late String language;
  late String URL;
  late String duration;
  late String source;
  late String title;
}
class Image_{
  late String language;
  late String URL;
  late String source;
  late String title;
}
class Text_{
  late String language;
  late String URL;
  late String source;
  late String title;
}
class URL_{
  late String language;
  late String url;
  late String source;
  late String title;
}
class Topic_{
  late int id;
  late String name;
  late List<Audio_> audios;
  late List<Video_> videos;
  late List<Image_> images;
  late List<URL_> urls;
  late Text_ pdf;

}
class Level_{
  late int id;
  late String name;
  //number of topics may not be needed
  late List<Topic_> topics;
}
class Course_ {
  late String code;
  late String name;
  late List<Instructor_> instructors;
  late List<Level_> levels;
  late List<String> learning_outcomes;
}
class Instructor_{
  late String name;
  late String department;
  late String contact;
}
