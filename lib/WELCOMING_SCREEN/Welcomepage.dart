import 'package:flutter/material.dart';
import 'package:flutter_application_1/AUTH_SCREEN/ACCOUNT_TYPE.dart';

// استبدلها بمسار الصفحة الصحيحة

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  void initState() {
    super.initState();
    // بعد 3 ثواني تنتقل لصفحة ACCOUNT_TYPE
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ACCOUNT_TYPE()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: screenHeight * 0.3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Pic12.png"),
                  fit: BoxFit.cover,
                ),
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
            ),
          )]));
    
  }
}
