import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/StProvider/StAuthentication_Provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isHidden = true;

  void _tryLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _studentIdCtrl.text.trim(),
      _passwordCtrl.text.trim(),
    );
    if (!success && auth.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error!)),
      );
    }
    // On success, AuthWrapper will rebuild and show HomePage
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder for logo
                  // Image.asset('assets/logo.png', height: 120),
                  const Text('Student Login', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 32),

                  TextFormField(
                    controller: _studentIdCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Student ID',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                    (v == null || v.isEmpty) ? 'Please enter Student ID' : null,
                    enabled: !auth.loading,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordCtrl,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black54,
                        ),
                        onPressed: () => setState(() => _isHidden = !_isHidden),
                      ),
                    ),
                    validator: (v) =>
                    (v == null || v.isEmpty) ? 'Please enter password' : null,
                    enabled: !auth.loading,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _tryLogin(),
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: auth.loading ? null : _tryLogin,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      child: auth.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
