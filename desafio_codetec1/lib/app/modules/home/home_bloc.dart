import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeBloc extends Disposable {

  String _selectedGender = "Masculino";
  get selectedGender => _selectedGender;
  set selectedGender(value) => _selectedGender = value;

  bool _portalUser = false;
  get portalUser => _portalUser;
  set portalUser(value) => _portalUser = value;

  final StreamController _streamController = StreamController.broadcast();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void inputSex(String sex){
    selectedGender = sex;
    input.add(selectedGender);
  }

  void inputPortalUser(bool value){
    portalUser = value;
    input.add(portalUser);
  }

  void clearName(TextEditingController controller) => controller.clear();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _streamController.close();
  }
}
