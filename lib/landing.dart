import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantin/login_view.dart';
import 'package:kantin/register_view.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/custom_checkbox.dart';
import 'package:kantin/widgets/primary_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 255, 0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME TO\n MY CANTEEN',
                    style: heading2.copyWith(color: textBlack),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/app.png',
                    width: 150,
                    height: 150,
                  )
                ],
              ),
              SizedBox(
                height: 90,
              ),
              GestureDetector(
                child: CustomPrimaryButton(
                    buttonColor: Color.fromARGB(255, 255, 115, 0),
                    textValue: 'Login',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: CustomPrimaryButton(
                    buttonColor: Color.fromARGB(255, 255, 115, 0),
                    textValue: 'Registrasi',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
