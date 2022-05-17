import 'package:bloc/bloc.dart';
import 'package:gp/Home.dart';
import 'package:gp/Dashboard_screen.dart';
import 'package:gp/myprofile_screen.dart';
import '../Learning_analytics_screen.dart';
import '../login_screen.dart';


import 'package:gp/Sidebar/sidebar_layout.dart';
import '../classes/student.dart';
import 'hom.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  analytics,
  profile,
  dashboard,
  logout,
}

abstract class NavigationStates {}

class Navigationn extends Bloc<NavigationEvents, NavigationStates> {
  student std;
  Navigationn(NavigationStates initialState, this.std) : super(initialState);

  // Navigationn(NavigationStates initialState) : super(INFO());
  @override
  NavigationStates get initialState => hhh();

  //Navigationn(NavigationStates initialState) : super(initialState);

  // Navigationn(NavigationStates initialState) : super(INFO());

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield Home(std);
        break;
      case NavigationEvents.analytics:
        yield Learning_analytics_screen(std);
        break;
      case NavigationEvents.dashboard:
        yield Dashboard_screen(std);
        break;
      case NavigationEvents.profile:
        yield MyProfileScreen(std);
        break;  
      case NavigationEvents.logout:
        yield Login_screen();
        break;
    }
  }
}
