


import 'package:flutter/material.dart';
import 'package:my_todo/app_colors.dart';

import '../todo/presentation/todo_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('building splash');
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TodoScreen()));

    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Center(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.primaryColor
            ),
            child: const Center(child: Text('My ToDo', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.whiteColor),)),
          ),
        ),
      ),
    );
  }
}
