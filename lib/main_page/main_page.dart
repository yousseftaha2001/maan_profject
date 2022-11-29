import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:string_similarity/string_similarity.dart';
import 'package:test_speak/main_page/main_page_controller.dart';
import 'package:test_speak/main_page/main_page_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainPageController controller = Get.put(MainPageController());
  final MainPageState state = Get.find<MainPageController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: controller.actionsManager,
        child: Container(
          color: Colors.white,
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<MainPageController>(
                builder: (controller) {
                  return AvatarGlow(
                    endRadius: 150.h,
                    glowColor: Colors.black,
                    showTwoGlows: true,
                    animate: state.isListening,
                    child: SizedBox(
                      width: 150.h,
                      child: Image.asset('assets/logo.png'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
