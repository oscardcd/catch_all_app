import 'package:catch_poke_app/app.dart';
import 'package:catch_poke_app/data/injector.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectableInit
void main() {
  configure('dev');

  runApp(App());
}
