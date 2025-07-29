import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/Auth_Provider.dart';
import 'package:to_do/UI/Home/AddTaskSheet.dart';
import 'package:to_do/UI/LoginScreen/login_screen.dart';
import 'package:to_do/UI/SettingsTab/settings_tab.dart';
import 'package:to_do/UI/TasksListTab/task_list.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var tabs = [TasksList(), const SettingsTab()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Management"),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            authProvider.logout();
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
        ),
      ),
      body: tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape:const StadiumBorder(side: BorderSide(width: 4, color: Colors.white)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          elevation: 0,
          items:const [
             BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddTaskSheet();
        });
  }
}
