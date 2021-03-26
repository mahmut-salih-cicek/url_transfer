
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_transfer/screens/mainScreen.dart';

void main()async{
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

    ),
  );

  WidgetsFlutterBinding.ensureInitialized();/// ASYNC İFADE KULLANDIGIMIZ İÇİN BUNU KESİNİLKLE KULLAN !!!
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}




