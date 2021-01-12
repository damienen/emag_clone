
import 'package:flutter/widgets.dart';

import 'home.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes{
  static const String home = '/';

  static final Map<String,WidgetBuilder> routes=<String,WidgetBuilder>{
    home:(BuildContext context)=> const Home(),
  };
}