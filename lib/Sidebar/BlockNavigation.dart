import 'package:bloc/bloc.dart';
import 'package:gp/Home.dart';
import 'package:gp/L_types.dart';

import 'package:gp/Last_quizes.dart';
import 'package:gp/Sidebar/sidebar_layout.dart';
import 'package:gp/signup%20screen.dart';

import '../Info.dart';

import '../Learning_analytics_screen.dart';
import '../classes/student.dart';
import '../login_screen.dart';
import 'hom.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  evalution,
  Infoevent,
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
      case NavigationEvents.evalution:
        yield lastQuizes(std);
        break;
      case NavigationEvents.Infoevent:
        yield INFO(std);
        break;
      case NavigationEvents.logout:
        yield Login_screen();
        break;
    }
  }
}
