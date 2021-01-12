import 'package:emag_clone/src/epics/app_epics.dart';
import 'package:emag_clone/src/models/index.dart';
import 'package:emag_clone/src/reducer/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

Future<Store<AppState>> init() async {
  const AppEpics epics = AppEpics();
  final AppState initialState = AppState.initialState();
  return Store<AppState>(
    reducer,
    initialState: initialState,
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epics),
    ],
  );
}