import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF29323E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              Image.asset(
                'assets/image/Logo.png',
                height: 80,
              ),
              const SizedBox(height: 70),
              TextField(
                controller: userController,
                decoration: InputDecoration(
                  hintText: 'Usuário',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xffffffff),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xffffffff),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 15,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/appbody');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.yellow),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                    minimumSize: WidgetStateProperty.all(
                      const Size(double.infinity, 50),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Esqueci a senha',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text.rich(
                  TextSpan(
                    text: 'Não tem uma conta? ',
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Crie uma',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
