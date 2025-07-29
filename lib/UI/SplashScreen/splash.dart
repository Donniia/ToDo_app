import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/Auth_Provider.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/UI/Home/home_screen.dart';
import 'package:to_do/UI/LoginScreen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = "splash";

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), (){
      Navigate(context);
    });
    return Scaffold(
      body: Center(child: Image.asset("Assets/images/logo.png")),
    );
  }

  void Navigate(BuildContext context) async {
    var authProvider = Provider.of<Auth_Provider>(context, listen: false);
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    if (authProvider.isUserLoggedInBefore()) {
      await authProvider.retrieveUserFromDatabase();
      tasksProvider.uid = authProvider.databaseUser?.id;
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}
