import 'dart:async';
import 'package:chatbotapp/provider/chatprovider.dart';
import 'package:chatbotapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOutBack);
    _animationController.repeat(reverse: true);

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => ChangeNotifierProvider(
      create: (context) => chatprovider(), // Providing ChatProvider instance
      child: ChatScreen(),
    ),
  ),
);

    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'asset/img/ic_logo.png',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Chat To Bot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
