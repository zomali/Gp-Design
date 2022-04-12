import 'package:bloc/bloc.dart';
import 'package:gp/Home.dart';
import 'package:gp/Sidebar/sidebar_layout.dart';

import '../Info.dart';
import '../Learning_analytics_screen.dart';
import '../classes/student.dart';
import '../login_screen.dart';
import 'hom.dart';
enum NavigationEvents {
  HomePageClickedEvent,
    evalution,
    Infoevent,
}
abstract class NavigationStates {}

class Navigationn extends Bloc<NavigationEvents,NavigationStates>{
  Navigationn(NavigationStates initialState) : super(initialState);

 // Navigationn(NavigationStates initialState) : super(INFO());
  @override
  NavigationStates get initialState => hhh();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield hhh();
        break;
      case NavigationEvents.Infoevent:
        yield INFO();
        break;

    }
  }

}

