import 'package:flutter/material.dart';
import 'package:users_app/users/welcome.dart';
import 'package:users_app/users/signin.dart';
import 'package:users_app/users/signup_page.dart';
import 'package:users_app/pages/homepage.dart';
import 'package:users_app/utils/get_color.dart';
import 'package:users_app/utils/get_shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: GetColor.primarySeedColor,
            onPrimary: GetColor.primarySeedColor,
            surfaceTint: GetColor.secondarySeedColor,
        ),
        iconTheme: IconThemeData(
          color: GetColor.primarySeedColor
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: GetColor.primarySeedColor,
          labelStyle: TextStyle(
            //backgroundColor: Colors.purple,
            color: GetColor.secondarySeedColor,
            fontSize: 16
          ),
          hintStyle: TextStyle(
            color: GetColor.secondarySeedColor,
            fontSize: 16,

          )
        ),

        textTheme: TextTheme(
          bodyMedium: TextStyle( //Welcome
            color: GetColor.primarySeedColor //Male/Female
          ),
          bodyLarge: TextStyle(
            color: GetColor.primarySeedColor //signin textfield entry
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GetColor.primarySeedColor,
            foregroundColor: GetColor.whiteTextColor
          ),
        ),

        //scaffoldBackgroundColor: GetColor.secondarySeedColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: GetColor.primarySeedColor,
          foregroundColor: GetColor.whiteTextColor,
          titleTextStyle: const TextStyle(
              fontSize: 22,
              letterSpacing: 5
          ),
        )
      ),

      //home: const SignInPage(),

      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/signin': (context) => const SignInPage(),
        '/signup' : (context) => const SignUpPage(),
        '/homepage' : (context) => const HomePage()
      },

      /*
      home: Scaffold(
        //appBar: PreferredSize(),
        body: const WelcomePage() //WelcomePage(),
      )*/
      //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



