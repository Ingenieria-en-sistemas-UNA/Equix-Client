import 'package:equix/src/blocs/category/bloc/bloc.dart';
import 'package:equix/src/blocs/provider.dart';
import 'package:equix/src/pages/login_page.dart';
import 'package:equix/src/pages/registro_page.dart';
import 'package:flutter/material.dart';

import 'package:equix/src/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/pages/phrase_page.dart';
import 'src/preferencias_usuario/PreferenciasUsuario.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CategoryBloc>(
        builder: (BuildContext context) => CategoryBloc(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Equix',
        initialRoute: prefs.token == '' ? 'login' : 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'phrase': (BuildContext context) => PhrasePage(),
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
        },
      ),
    );
  }
}
