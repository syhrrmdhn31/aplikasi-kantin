import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kantin/home_screen.dart';
import 'package:kantin/landing.dart';
import 'package:kantin/widgets/MenuPage.dart';
import 'package:kantin/register_view.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/widgets/custom_checkbox.dart';
import 'package:kantin/widgets/primary_button.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  TextEditingController nis = TextEditingController();
  TextEditingController password = TextEditingController();
  Future login() async {
    if (nis.text.isEmpty && password.text.isEmpty) {
      Alert(
              context: context,
              title: "Data Tidak Boleh Kosong",
              type: AlertType.warning)
          .show();
    } else if (nis.text.isEmpty) {
      Alert(
              context: context,
              title: "NIS Tidak Boleh Kosong",
              type: AlertType.warning)
          .show();
    } else if (password.text.isEmpty) {
      Alert(
              context: context,
              title: "Password Tidak Boleh Kosong",
              type: AlertType.warning)
          .show();
    } else {
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(
        max: 100,
        msg: 'Masuk....',
        progressBgColor: Colors.transparent,
      );
      for (int i = 0; i <= 100; i++) {
        pd.update(value: i);
        i++;
        await Future.delayed(Duration(milliseconds: 50));
      }

      var url = Uri.http(
          "192.168.1.19", '/login-register/login.php', {'q': '{http}'});
      var response = await http.post(url, body: {
        "NIS": nis.text,
        "password": password.text.toString(),
      });
      var data = json.decode(response.body);
      if (data.toString() == "Success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        Alert(context: context, title: "Login Gagal", type: AlertType.error)
            .show();
      }
    }
  }

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 255, 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: heading2.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'assets/images/app.png',
                    width: 150,
                    height: 150,
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Form(
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextFormField(
                      controller: nis,
                      decoration: InputDecoration(
                          hintText: 'NIS',
                          hintStyle: heading6.copyWith(color: textGrey),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextFormField(
                      controller: password,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: heading6.copyWith(color: textGrey),
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  )
                ],
              )),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCheckbox(),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Remember me',
                    style: regular16pt,
                  )
                ],
              ),
              SizedBox(
                height: 82,
              ),
              CustomPrimaryButton(
                buttonColor: Color.fromARGB(255, 255, 115, 0),
                textValue: 'Login',
                textColor: Colors.white,
                onPressed: () {
                  login();
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      'Register',
                      style: regular16pt.copyWith(color: primaryBlue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
