import 'package:frontendapp/supabase_credentials.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthentificationServices{

  Future<void> signup({required String email,
  required String password,
  }) async{
    final supabase = Supabase.instance.client.auth.signUp(password: password, email: email);

  if(supabase == null){
 
  }

  }

}