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
                children: [
                  const SizedBox(height: 48),
                  const Text('Student Login', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 32),

                  TextFormField(
                    controller: _studentIdCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Student ID',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    // validator: (v) =>
                    // (v == null || v.isEmpty) ? 'Please enter Student ID' : null,
                    // enabled: !auth.loading,
                    // textInputAction: TextInputAction.next,
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
                        ),
                        onPressed: () => setState(() => _isHidden = !_isHidden),
                      ),
                    ),
                    // validator: (v) =>
                    // (v == null || v.isEmpty) ? 'Please enter password' : null,
                    // enabled: !auth.loading,
                    // textInputAction: TextInputAction.done,
                    // onFieldSubmitted: (_) => _tryLogin(),
                  ),

                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: auth.loading
                          ? null
                          : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: auth.loading ? null : _tryLogin,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade900
                      ),
                      child: auth.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Login', style: TextStyle(fontSize: 18,color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  bool _loading = false;
  String? _message;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _message = null; });

    try {
      // call your backend, e.g. via Dio
      // await AuthService.forgotPassword(_idCtrl.text.trim());
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _message = 'Password reset link sent to your email/mobile.';
      });
    } catch (e) {
      setState(() { _message = 'Error sending reset link.'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'Enter your Student ID to receive a password reset link.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _idCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Student ID',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  (v == null || v.isEmpty) ? 'Please enter Student ID' : null,
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit',style: TextStyle(color: Colors.white),),
                ),
              ),
              if (_message != null) ...[
                const SizedBox(height: 16),
                Text(_message!, style: const TextStyle(color: Colors.green)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
