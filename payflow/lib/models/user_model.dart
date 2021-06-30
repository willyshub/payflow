import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURL;

  UserModel({required this.name, this.photoURL});

  /// Constroi através de map.
  /// E, retorna uma instancia de UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], photoURL: map['photoURL']);
  }

  /// Constroi através de json.
  /// Converte o json em um map
  factory UserModel.fromJson(String json) => UserModel.fromMap(
        jsonDecode(json),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "photoURL": name,
      };
  String toJson() => jsonEncode(toMap());
}
