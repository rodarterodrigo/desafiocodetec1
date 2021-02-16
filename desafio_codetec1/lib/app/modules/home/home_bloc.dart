import 'dart:async';
import 'package:desafio_codetec1/app/modules/models/home_model.dart';
import 'package:desafio_codetec1/app/modules/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeBloc extends Disposable {

  final HomeModel homeModel = HomeModel();

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(value) => _isLoading = value;

  final StreamController _streamController = StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void inputLoadin(bool value){
    this.isLoading = value;
    input.add(this.isLoading);
  }

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

  void inputReservist(String reservist){
    this.homeModel.reservist = reservist;
    input.add(homeModel);
  }

  Future loading() async {
    this.changeLoading();
    Timer(Duration(seconds: 2), () async {
      await Modular.to.pushNamed(Routes.SUCCESSPAGE);
      this.changeLoading();
    });
  }

  void clearName(TextEditingController controller) { controller.clear(); this.homeModel.name = ""; this.input.add(this.homeModel); }
  void clearReservist(TextEditingController controller) { controller.clear(); this.homeModel.reservist = ""; this.input.add(this.homeModel); }

  Future commit() async => await loading();

  void changeLoading() {
    this.isLoading = !this.isLoading;
    this.input.add(isLoading);
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
