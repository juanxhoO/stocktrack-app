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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Inventory Stock App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loginState.error != null)
              Text(
                loginState.error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Keeps the column compact
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns label to the left

                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Keeps the column compact
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns label to the left
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),

                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ), // ✅ comma
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),

                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.blue.shade700;
                    }
                    return Colors.blue;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.yellow;
                    }
                    return Colors.white;
                  }),
                ),
                onPressed: loginState.isLoading ? null : _onLoginPressed,
                child: loginState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
            ), // ✅ comma
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      style: ButtonStyle(
                        mouseCursor: WidgetStatePropertyAll(
                          SystemMouseCursors.click,
                        ),
                        foregroundColor: WidgetStateProperty.resolveWith((
                          states,
                        ) {
                          return states.contains(WidgetState.hovered)
                              ? Colors.blue.shade700
                              : Colors.blue;
                        }),
                      ),
                      onPressed: () => context.go('/signup'),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  style: ButtonStyle(
                    mouseCursor: WidgetStatePropertyAll(
                      SystemMouseCursors.click,
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      return states.contains(WidgetState.hovered)
                          ? Colors.blue.shade700
                          : Colors.blue;
                    }),
                  ),
                  onPressed: () => context.go('/forgot-password'),
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
