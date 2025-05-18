import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final birthdateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', usernameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('birthdate', birthdateController.text);
    await prefs.setString('password', passwordController.text);
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      await saveUserData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Hello! Register to get started",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your username" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (value) => value!.isEmpty ? "Enter your age" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: birthdateController,
                decoration: const InputDecoration(labelText: "Birthdate"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your birthdate" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your password" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
                validator: (value) => value != passwordController.text
                    ? "Passwords do not match"
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Register"),
              ),
              const SizedBox(height: 24),
              const Text("Or Register with"),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.g_mobiledata, size: 36),
                  SizedBox(width: 16),
                  Icon(Icons.facebook, size: 28),
                  SizedBox(width: 16),
                  Icon(Icons.apple, size: 28),
                ],
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: const Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
