import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/theme_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Center(
        child: GestureDetector(
          onTap: (){
            themeProvider.changeTheme(ThemeMode.dark);
          },
          onDoubleTap: (){
            themeProvider.changeTheme(ThemeMode.light);
          },
          child: Container(
                alignment: Alignment.center,
                width: 120,
                height: 50,
                decoration: BoxDecoration(
            color: theme.primaryColor, borderRadius: BorderRadius.circular(15)),
                child: Text(
          "Change Theme",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
        ));
  }
}
