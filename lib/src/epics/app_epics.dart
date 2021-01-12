import 'package:emag_clone/src/data/auth_api.dart';
import 'package:emag_clone/src/epics/auth_epics.dart';
import 'package:emag_clone/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:meta/meta.dart';

class AppEpics {
  const AppEpics({@required AuthApi api})
      : assert(api != null),
        _authApi = api;

  final AuthApi _authApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      AuthEpics(api: _authApi).epics,
    ]);
  }
}
