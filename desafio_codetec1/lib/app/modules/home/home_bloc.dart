import 'dart:async';
import 'package:desafio_codetec1/app/modules/models/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeBloc extends Disposable {

  HomeModel homeModel = HomeModel();

  final StreamController _streamController = StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void inputName(String name){
    this.homeModel.name = name;
    input.add(this.homeModel);
  }

  void inputSex(String sex){
    this.homeModel.gender = sex;
    input.add(homeModel);
  }

  void inputPortalUser(bool value){
    this.homeModel.isPortalUser = value;
    input.add(homeModel);
  }

  void clearName(TextEditingController controller) => controller.clear();

  @override
  void dispose() {
    _streamController.close();
  }
}
