import 'dart:convert';

import 'package:zeta_house/entidade/usuario.dart';

class ServiceResult <T> {
  bool success;
  T data;
  String errorMessage;

  ServiceResult(){

  }

  ServiceResult.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      data = json['data'],
      errorMessage = json['errorMessage'];


}