import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_do/Providers/Auth_Provider.dart';
import 'package:to_do/UI/LoginScreen/login_screen.dart';
import 'package:to_do/UI/dialogutils.dart';
import 'package:to_do/UI/widgets/CustomFormField.dart';
import 'package:to_do/firebaseErrorCode.dart';

import '../../validationUtils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullname = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController passwordConfirm = TextEditingController();

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
                  controller: fullname,
                  hint: "Full Name",
                  KeyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter full name";
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  controller: userName,
                  hint: "User Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter user name";
                    }
                    return null;
                  },
                ),
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
                CustomFormField(
                    controller: passwordConfirm,
                    hint: "password Confirmation",
                    secureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter password";
                      }
                      if (value.length < 8) {
                        return "password length must be at least 8";
                      }
                      if (password.text != value) {
                        return "password does not match";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () {
                      creatAccount();
                    },
                    child: Text("Create Account")),
                TextButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                }, child: Text("Already have account ?"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void creatAccount() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    var authProvider = Provider.of<Auth_Provider>(context,listen: false);
    try {
      Dialogutils.showLoading(context, "loading");
      authProvider.register(email.text,password.text,userName.text,fullname.text);
      Dialogutils.HideDialog(context);
      Dialogutils.showMessage(context, "Registered Successfully",
          posActionTitle: "Ok", posAction: () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrorCode.weakPass) {
        Dialogutils.showMessage(context, "The password provided is too weak.");
      } else if (e.code == FirebaseErrorCode.emailInUse) {
        Dialogutils.showMessage(
            context, "The account already exists for that email.");
      }
    } catch (e) {
      Dialogutils.showMessage(
          context, "Something Went Wrong");
    }
  }
}
