import 'package:emag_clone/src/actions/index.dart';
import 'package:emag_clone/src/data/auth_api.dart';
import 'package:emag_clone/src/models/auth/index.dart';
import 'package:emag_clone/src/models/index.dart';
import 'package:meta/meta.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AuthEpics {
  const AuthEpics({@required AuthApi api})
      : assert(api != null),
        _api = api;

  final AuthApi _api;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, Login$>(_login),
      TypedEpic<AppState, Register$>(_register),
      TypedEpic<AppState, LoginWithGoogle$>(_loginWithGoogle),
      TypedEpic<AppState, Logout$>(_logout),
      TypedEpic<AppState, ForgotPassword$>(_forgotPassword),
    ]);
  }

  Stream<AppAction> _login(Stream<Login$> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((Login$ action) => Stream<Login$>.value(action)
        .asyncMap((Login$ action) => _api.login(email: action.email, password: action.password))
        .map((AppUser user) => Login.successful(user))
        .onErrorReturnWith((dynamic error) => Login.error(error))
        .doOnData(action.response));
  }

  Stream<AppAction> _register(Stream<Register$> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((Register$ action) => Stream<Register$>.value(action)
        .asyncMap((Register$ action) => _api.register(
      email: store.state.auth.info.email,
      password: store.state.auth.info.password,
      displayName: store.state.auth.info.displayName ?? store.state.auth.info.email.split('@')[0],
    ))
        .map((AppUser user) => Register.successful(user))
        .onErrorReturnWith((dynamic error) => Register.error(error))
        .doOnData(action.response));
  }

  Stream<AppAction> _loginWithGoogle(Stream<LoginWithGoogle$> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((LoginWithGoogle$ action) => Stream<LoginWithGoogle$>.value(action)
        .asyncMap((LoginWithGoogle$ action) => _api.loginWithGoogle())
        .map((AppUser user) => LoginWithGoogle.successful(user))
        .onErrorReturnWith((dynamic error) => LoginWithGoogle.error(error))
        .doOnData(action.response));
  }

  Stream<AppAction> _logout(Stream<Logout$> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((Logout$ action) => Stream<Logout$>.value(action)
        .asyncMap((Logout$ action) => _api.logout())
        .map((_) => const Logout.successful())
        .onErrorReturnWith((dynamic error) => Logout.error(error)));
  }

  Stream<AppAction> _forgotPassword(Stream<ForgotPassword$> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((ForgotPassword$ action) => Stream<ForgotPassword$>.value(action)
        .asyncMap((ForgotPassword$ action) => _api.forgotPassword(action.email))
        .map((_) => const ForgotPassword.successful())
        .onErrorReturnWith((dynamic error) => ForgotPassword.error(error)));
  }
}