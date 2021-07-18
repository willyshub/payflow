import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController {
  final controller = AuthController(); 

  /// Get email do email google logado
  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = await GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
      );
      controller.setUser(context, user);
      print(response);
    } catch (error) {
      print(error);
      controller.setUser(context, null);
    }
  }
}
