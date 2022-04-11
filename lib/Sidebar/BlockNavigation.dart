import 'package:bloc/bloc.dart';
import 'package:gp/Home.dart';
import 'package:gp/L_types.dart';
import 'package:gp/Last_Quiazes.dart';
import 'package:gp/Sidebar/sidebar_layout.dart';

import '../pages/Info.dart';
import '../Learning_analytics_screen.dart';
import '../classes/student.dart';
import '../login_screen.dart';
import '../pages/hom.dart';
enum NavigationEvents {
  HomePageClickedEvent,
    evalution,
    Infoevent,
  logout,
}
abstract class NavigationStates {}

class Navigationn extends Bloc<NavigationEvents,NavigationStates>{
  Navigationn(NavigationStates initialState) : super(initialState);

  @override
  lastQuizes get initialState => lastQuizes();


  //Navigationn(NavigationStates initialState) : super(initialState);

 // Navigationn(NavigationStates initialState) : super(INFO());

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {

    switch(event){
      case NavigationEvents.HomePageClickedEvent:
        yield hhh();
        break;
      case NavigationEvents.evalution:
        yield lastQuizes();
        break;
      case NavigationEvents.Infoevent:
        yield INFO();
        break;
      case NavigationEvents.logout:
        yield Login_screen();
        break;



    }
  }

}

