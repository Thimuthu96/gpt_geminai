import 'package:flutter/material.dart';
import 'package:gpt_geminai/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _handleOnboard(bool value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isOnboarded', value); // Storing the value
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: size.height * 0.1,
          bottom: 20,
        ),
        child: const Center(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "GPT Geminai",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    "Chat smarter, connect faster, and get instant answers with your AI-powered conversation partner!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Image(
                    image: NetworkImage(
                        'https://img.freepik.com/free-vector/cartoon-style-robot-vectorart_78370-4103.jpg?t=st=1732791466~exp=1732795066~hmac=4e06a505105297c7970a1ad55ea3dca780a2398cd1ec36505720c1280b98c8d5&w=996'),
                  ),
                ),
              ),
              // Expanded(flex: 1, child: Text("button")),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.8,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.blueGrey,
                onPressed: () async {
                  _handleOnboard(true);
                  Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                  // Navigator.pushNamed(context, AppRoutes.homeScreen);
                },
                label: const Row(
                  children: [
                    Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(width: 40),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
