import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  bool _isAuthenticated = false;
  UserModel? _user;
  UserModel get user => _user!;

  /// Verifica se há [User] logado e navega para determinada página
  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      this._isAuthenticated = true;
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      this._isAuthenticated = false;
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  /// Salva em formato json utilizando o SharedPreference.
  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  /// Retorna o setUser dizendo estar ou não logado.
  /// Baseando-se na respota, navega para páginas diferentes.
  Future<void> currentUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));

    /// Package nativo necessita rebuild do zero.
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("user")) {
      final json = instance.getString("user") as String;
      setUser(context, UserModel.fromJson(json));
    } else {
      setUser(context, null);
    }
    return;
  }
}
