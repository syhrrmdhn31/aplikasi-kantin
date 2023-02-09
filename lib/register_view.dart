import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kantin/widgets/MenuPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kantin/theme.dart';
import 'package:kantin/login_view.dart';
import 'package:kantin/widgets/custom_checkbox.dart';
import 'package:kantin/widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nis = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = false;
  bool passwordConfirmVisible = false;

  Future register() async {
    if (nis.text.isEmpty && nama.text.isEmpty && password.text.isEmpty) {
      Alert(
              context: context,
              title: "Data Tidak Boleh Kosong",
              type: AlertType.warning)
          .show();
    } else if (nis.text.isEmpty) {
      Alert(
              context: context,
              title: "Harap Mengisi NIS !",
              type: AlertType.warning)
          .show();
    } else if (nama.text.isEmpty) {
      Alert(
              context: context,
              title: "Harap Mengisi Nama Anda",
              type: AlertType.warning)
          .show();
    } else if (password.text.isEmpty) {
      Alert(
              context: context,
              title: "Harap Mengisi Kata Sandi Anda !",
              type: AlertType.warning)
          .show();
    } else {
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(
        max: 100,
        msg: 'Daftar...',
        progressBgColor: Colors.transparent,
      );
      for (int i = 0; i <= 100; i++) {
        pd.update(value: i);
        i++;
        await Future.delayed(Duration(milliseconds: 50));
      }
      var url = Uri.http(
          "192.168.1.19", "/login-register/register.php", {'q': '{http}'});
      var response = await http.post(url, body: {
        "NIS": nis.text,
        "nama": nama.text.toString(),
        "password": password.text.toString()
      });
      var data = json.decode(response.body);
      if (data.toString() == "Error") {
        Alert(
                context: context,
                title: "NIS Sudah Terdaftar",
                type: AlertType.warning)
            .show();
        ;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
        Alert(
                context: context,
                title: "Berhasil Membuat Akun",
                type: AlertType.success)
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
                  'REGISTER',
                  style: heading2.copyWith(color: textBlack),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/app.png',
                  width: 150,
                  height: 150,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Form(
                child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: textWhiteGrey,
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
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: textWhiteGrey,
                      borderRadius: BorderRadius.circular(14)),
                  child: TextFormField(
                    controller: nama,
                    decoration: InputDecoration(
                        hintText: 'Nama',
                        hintStyle: heading6.copyWith(color: textGrey),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: textWhiteGrey,
                      borderRadius: BorderRadius.circular(14)),
                  child: TextFormField(
                    controller: password,
                    obscureText: !passwordConfirmVisible,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: heading6.copyWith(color: textGrey),
                        suffixIcon: IconButton(
                          color: textGrey,
                          splashRadius: 1,
                          icon: Icon(passwordConfirmVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              passwordConfirmVisible = !passwordConfirmVisible;
                            });
                          },
                        ),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                )
              ],
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomCheckbox(),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By creating an account, you agree to our',
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    Text(
                      'Term & Condition',
                      style: regular16pt.copyWith(color: primaryBlue),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomPrimaryButton(
              buttonColor: Color.fromARGB(255, 255, 115, 0),
              textValue: 'Register',
              textColor: Colors.white,
              onPressed: () {
                register();
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: regular16pt.copyWith(color: textGrey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Login',
                    style: regular16pt.copyWith(color: primaryBlue),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
