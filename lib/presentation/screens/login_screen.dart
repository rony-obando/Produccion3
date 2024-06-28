import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontendapp/presentation/providers/login_provider.dart';
import 'package:frontendapp/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class login_screen extends StatefulWidget {
  login_screen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<login_screen> {
  SupabaseClient client = Supabase.instance.client;
  bool _isLoading = false;

  Future<bool> signUp(String email, String password, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Ocurrió un error al crear la cuenta');
      } else {
        context.read<LoginProvider>().setLoginprops(id: response.user?.uid);
        await context.read<ProductProvider>().setUsuario(response.user?.uid);
        await client.from('Usuario').insert({'email': email, 'id': response.user?.uid});
        return response.user!.uid.isNotEmpty ? true : false;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                Text(
                  'Error',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Text(
              '$e',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      return false;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> signIn(String email, String password, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Ocurrió un error al iniciar sesión');
      } else {
        context.read<LoginProvider>().setLoginprops(id: response.user?.uid);
        await context.read<ProductProvider>().setUsuario(response.user?.uid);
        return response.user!.uid.isNotEmpty ? true : false;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                Text(
                  'Error',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: const Text(
              'Ocurrió un error al iniciar sesión',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
      return false;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider watch = context.watch<LoginProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Center(
            child: Text(
              'Manejo de inventario',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              watch.buttontext.contains('Crear') ? 'Iniciar sesión' : 'Crear cuenta',
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Image.asset(
                'assets/icon/logouni12.png',
                width: 250,
                height: 250,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onChanged: (String text) {
                context.read<LoginProvider>().setLoginprops(email: text);
              },
            ),
            const SizedBox(height: 40),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onChanged: (String text) {
                context.read<LoginProvider>().setLoginprops(password: text);
              },
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(watch.text),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(90, 5),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {
                    if (watch.buttontext.contains('Crear')) {
                      context.read<LoginProvider>().setLoginprops(buttontext: 'Iniciar sesión');
                      context.read<LoginProvider>().setLoginprops(text: '¿Ya tienes cuenta?');
                    } else {
                      context.read<LoginProvider>().setLoginprops(buttontext: 'Crear cuenta');
                      context.read<LoginProvider>().setLoginprops(text: '¿No tienes cuenta?');
                    }
                  },
                  child: Text(watch.buttontext),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 42, 37, 201),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (!watch.buttontext.contains('Crear')) {
                            if (await signUp(watch.email, watch.password, context)) {
                              Navigator.pushNamed(context, 'Optiosn_Screen');
                            }
                          } else {
                            if (await signIn(watch.email, watch.password, context)) {
                              Navigator.pushNamed(context, 'Optiosn_Screen');
                            }
                          }
                        },
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('Ingresar', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
