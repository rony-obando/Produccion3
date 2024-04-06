
import 'package:flutter/material.dart';



// ignore: camel_case_types
class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {



  @override



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
        ) 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
             const SizedBox(height: 50.0),
            Image.asset(
              'assets/icon/logouni12.png', // Ruta de la imagen en tu proyecto
              width: 250, // Ancho de la imagen
              height: 250, // Alto de la imagen
            ),
            const SizedBox(height: 50),
             TextField(
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                //labelStyle: TextStyle(backgroundColor: Colors.blue),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                
              ),
              onChanged: (String text) {
                   setState(() {
                //     _emailController.text = text.toString();
                   });
                  },
            ),
            const SizedBox(height: 30),
             TextField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onChanged: (String text) {
                   setState(() {
                 //    _passworController.text = text.toString();
                   });
                  },
              obscureText: true,
            ),
            SizedBox(height: 50),
            Align(
               alignment: Alignment.centerRight,
               child: ElevatedButton(
                 onPressed: () {
                  
                //  signInWithGoogle();

                 // Navigator.pushNamed(context,'Menu_Screen');
                 
          // Aquí puedes agregar la lógica para el inicio de sesión
                 },
        child: const Text('Iniciar sesión'),
      ),
    ),
        
          ],
        ),
      ),
    );
  }
}