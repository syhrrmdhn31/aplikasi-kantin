import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:kantin/launcher.dart';
import 'package:kantin/pages/AyamGeprekPage.dart';
import 'package:kantin/pages/BaksoPage.dart';
import 'package:kantin/pages/CartPage.dart';
import 'package:kantin/pages/CilokPage.dart';
import 'package:kantin/pages/EsJerukPage.dart';
import 'package:kantin/pages/EsKopyorPage.dart';
import 'package:kantin/pages/EsSusuPage.dart';
import 'package:kantin/pages/EsTehPage.dart';
import 'package:kantin/pages/MartabakPage.dart';
import 'package:kantin/pages/RisolPage.dart';
import 'package:kantin/pages/SotoAyamPage.dart';
import 'package:kantin/pages/TempePage.dart';
import 'package:kantin/widgets/MenuPage.dart';
import 'package:kantin/pages/NasiGorengPage.dart';
import 'package:kantin/widgets/MenuItems.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        "/": (context) => LauncherPage(),
        "cartPage": (context) => CartPage(),
        "nasigorengpage": (context) => NasiGorengPage(),
        "ayamgeprekpage": (context) => AyamGeprekPage(),
        "sotoayampage": (context) => SotoAyamPage(),
        "baksopage": (context) => BaksoPage(),
        "estehpage": (context) => EsTehPage(),
        "esjerukpage": (context) => EsJerukPage(),
        "eskopyorpage": (context) => EsKopyorPage(),
        "essusupage": (context) => EsSusuPage(),
        "risolpage": (context) => RisolPage(),
        "tempepage": (context) => TempePage(),
        "cilokpage": (context) => CilokPage(),
        "martabakpage": (context) => MartabakPage(),
      },
    );
  }
}
