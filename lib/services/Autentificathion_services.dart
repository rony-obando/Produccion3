import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthentificationServices{
  SupabaseClient client = Supabase.instance.client;
   

   Future<void> signIn(String email, String password, BuildContext context) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
     
    } else {
     print('!!!!Se inicio Sesion!!!!!!');
    }
  }
  

  

}