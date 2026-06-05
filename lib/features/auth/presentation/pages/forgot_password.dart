import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/login_controller.dart';
import '../../../../shared/widgets/header.dart';


class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmitPressed() {
    if (!_formKey.currentState!.validate()) return;
    // hook up to your reset password controller
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Appheader(
              title: "Reset password",
              icon: Icons.lock_open,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: _submitted ? _buildSuccessState() : _buildFormState(loginState),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Success state ──────────────────────────────────────
  Widget _buildSuccessState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.mark_email_read_outlined,
              size: 36, color: Colors.green.shade400),
        ),
        const SizedBox(height: 24),
        const Text(
          'Check your inbox',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a password reset link to\n${_emailController.text}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => context.go('/login'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Back to login'),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => setState(() => _submitted = false),
          child: Text(
            'Resend email',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }

  // ── Form state ─────────────────────────────────────────
  Widget _buildFormState(LoginState loginState) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter your email and we\'ll send you a link to reset your password.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 32),

          // ── Error ──────────────────────────────────────
          if (loginState.error != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline,
                      color: Colors.red.shade400, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      loginState.error!,
                      style: TextStyle(
                          color: Colors.red.shade700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // ── Email ──────────────────────────────────────
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                return 'Enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'john@company.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Submit ─────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: loginState.isLoading ? null : _onSubmitPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: loginState.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Send reset link',
                      style: TextStyle(fontSize: 15),
                    ),
            ),
          ),
          const SizedBox(height: 20),

          // ── Back to login ──────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Remember your password? ',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              GestureDetector(
                onTap: () => context.go('/login'),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}