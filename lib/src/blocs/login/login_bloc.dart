


import 'dart:async';

import 'package:equix/src/models/author_model.dart';
import 'package:rxdart/rxdart.dart';

import '../validator.dart';

class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _authorController = BehaviorSubject<Author>();

  // Recuperar los datos del stream

  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform( validatePassword );
  Stream<String> get nameStream => _passwordController.stream;
  Stream<Author> get authorStream => _authorController.stream;
  Stream<bool> get formValidStream => 
    Observable.combineLatest2(emailStream, passwordStream, ( e, p ) => true );

  // Insertar valores añ Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(Author) get changeAuthor => _authorController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _nameController.value;
  Author get author => _authorController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _nameController?.close();
    _authorController?.close();
  }

}

