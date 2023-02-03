import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_Controller.dart';
import '../models/role_Model.dart';

class RoleProvider with ChangeNotifier {
  Role? _role;

  final AuthControllers _authMethods = AuthControllers();

  Role? get getRole => _role;

  Future<void> refreshUser() async {
    Role role = await _authMethods.getRoleDetails();
    _role = role;
    notifyListeners();
  }
}
