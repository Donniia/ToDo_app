import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Database/UserDao.dart';
import 'package:to_do/Providers/tasks_provider.dart';
import 'package:to_do/UI/Home/home_screen.dart';
import 'package:to_do/UI/RegisterScreen/register_screen.dart';
import 'package:to_do/UI/dialogutils.dart';
import 'package:to_do/firebaseErrorCode.dart';

import '../../Providers/Auth_Provider.dart';
import '../../validationUtils.dart';
import '../widgets/CustomFormField.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("Assets/images/background.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFormField(
                  controller: email,
                  hint: "Email",
                  KeyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter email";
                    }
                    if (!isValidEmail(value)) {
                      return "wrong email address";
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  controller: password,
                  hint: "Password",
                  secureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter password";
                    }
                    if (value.length < 8) {
                      return "password length must be at least 8";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      Login();
                    },
                    child: Text("Login")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.routeName);
                    },
                    child: Text("Don't have account?"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Login() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    var authProvider = Provider.of<Auth_Provider>(context, listen: false);
    var tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    try {
      Dialogutils.showLoading(context, "Loading....", isCanceled: false);

      await authProvider.login(email.text, password.text);
      tasksProvider.uid = authProvider.databaseUser?.id;
      Dialogutils.HideDialog(context);
      Dialogutils.showMessage(context, "LoggedIn Successfully",
          posActionTitle: "Ok", posAction: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      Dialogutils.HideDialog(context);
      print(e.code);
      if (e.code == FirebaseErrorCode.userNotFound ||
          e.code == FirebaseErrorCode.wrongPass ||
          e.code == FirebaseErrorCode.invalidCredential) {
        Dialogutils.showMessage(context, "Wrong Email or Password",
            posActionTitle: "Ok", posAction: () {
          Navigator.pop(context);
        });
      }
    }
  }
}
