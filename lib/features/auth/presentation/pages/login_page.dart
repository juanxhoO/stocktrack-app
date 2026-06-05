import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/login_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final email = _emailController.text;
    final password = _passwordController.text;
    
    ref.read(loginControllerProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    // Navigate to profile when login succeeds
    ref.listen<LoginState>(loginControllerProvider, (previous, next) {
      if (next.isSuccess) {
        context.go('/profile');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loginState.error != null)
              Text(
                loginState.error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loginState.isLoading ? null : _onLoginPressed,
                child: loginState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
            ),
             const SizedBox(height: 24),
MouseRegion(
  cursor: SystemMouseCursors.click,
  child: InkWell(
    onTap: () => context.go('/forgot-password'),
    child: const Text(
      'Forgot Password?',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)
          ],
        ),
      ),
    );
  }
}
