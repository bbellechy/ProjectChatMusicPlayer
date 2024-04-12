
import 'dart:io';

import 'package:chatmusic/models/playlist_provider.dart';
import 'package:chatmusic/models/profile.dart';
import 'package:chatmusic/pages/chatOnline.dart';
import 'package:chatmusic/pages/favoriteSong.dart';
import 'package:chatmusic/pages/home_page.dart';
import 'package:chatmusic/pages/login.dart';
import 'package:chatmusic/pages/popupSongPage.dart';
import 'package:chatmusic/pages/profile.dart';
import 'package:chatmusic/pages/register.dart';
import 'package:chatmusic/pages/searchMusic.dart';
import 'package:chatmusic/pages/setting.dart';
import 'package:chatmusic/pages/streaming.dart';
import 'package:chatmusic/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options:  FirebaseOptions(
      apiKey: "AIzaSyAjaR50v-1Q4eiQNjwWNeaEw3rzdtRisDw", 
      appId: "1:206232416345:android:6afcc7b4bb0fa28e7ac148", 
      messagingSenderId: "206232416345", 
      projectId: "chatmusicplayer")
  ) : await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      ChangeNotifierProvider(create: (context)=> PlaylistProvider()),
    ],
    child: const MyApp(),)
  );
  ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),

      routes: {
        '/streaming':(context) => const StreamingPage(),
        '/chat':(context) => const ChatOnlinePage(),
        'search':(context) => const searchMusic(),
        'favsong':(context) => const FavoriteSong(),
        '/profile':(context) => const MyProfile(),
        'popupsong':(context) => const PopupSong(),
        '/login':(context) => const Login(),
        '/register':(context) => const Register(),
        '/setting':(context) => const settingPage(),
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
      
    );
  }
}

    // late final GoRouter _router = GoRouter(
    // routes: <GoRoute>[
    //   GoRoute(
    //     path: '/',
    //     builder: (BuildContext context, GoRouterState state) => const StreamingPage(),
    //   ),
    //   GoRoute(
    //     path: '/login',
    //     builder: (BuildContext context, GoRouterState state) => const Login(),
    //   ),
    // ],
    //     // redirect to the login page if the user is not logged in
    // redirect: (BuildContext context, GoRouterState state) {
    //   // final bool loggedIn = _loginInfo.loggedIn;
    //   final bool loggingIn = state.matchedLocation == '/login';
    //   if (!loggingIn) {
    //     return '/login';
    //   }
    //   if (loggingIn) {
    //     return '/';
    //   }
    //   return null;
    // },
    // // changes on the listenable will cause the router to refresh its route
    // refreshListenable: _loginInfo,
    // ),