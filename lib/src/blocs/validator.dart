import 'dart:async';

class Validators {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( String email, sink ) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if( regExp.hasMatch(email) ) {
        sink.add( email );
      } else {
        sink.addError('Email no es correcto');
      }
    }
  );
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( String password, sink ) {
      if( password.length >= 10 ) {
        sink.add( password );
      } else {
        sink.addError('Más de 6 caracteres por favor');
      }
    }
  );

}