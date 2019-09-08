import 'package:equix/src/blocs/category/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:equix/src/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/pages/phrase_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          builder: (BuildContext context) => CategoryBloc(),
        )
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equix',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'phrase' : (BuildContext context) => PhrasePage()
      },
    );
  }
}
