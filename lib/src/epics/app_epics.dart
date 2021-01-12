
import 'package:emag_clone/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';

class AppEpics{
  const AppEpics();

  Epic<AppState> get epics{
    return combineEpics(<Epic<AppState>>[]);
  }
}