import 'package:fastrepaire/routes/my_routes.dart';
import 'package:fastrepaire/routes/routes.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = new Router();
    Routes.configureRoutes(router);
    AppRoutes.router = router;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '闪电修',
      initialRoute: "/",
      onGenerateRoute: AppRoutes.router.generator,
    );
  }
}
