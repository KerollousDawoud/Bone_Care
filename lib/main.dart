import 'package:dopproject/layout/layout.dart';
import 'package:dopproject/shared/cacheHelper.dart';
import 'package:dopproject/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'login_screen/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  isUser = await CacheHelper.getData(key: 'login');
  uId = await CacheHelper.getData(key: 'uId');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.lightBlueAccent,
      canvasColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
    home: isUser == 'user' ? HomeLayout() : Login(),
  ));
}
