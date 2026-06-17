import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_controller.dart';
import 'package:stocktrack_app/shared/widgets/sidebar.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onSignupPressed() {
    if (!_formKey.currentState!.validate()) return;
    // hook up to your signup controller
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(profileControllerProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      drawer: isDesktop ? null : const AppSidebar(),
      appBar: AppBar(title: const Text('Profile')),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SizedBox(width: 280, child: AppSidebar()),
          Expanded(child: _buildBody(profileState)),
        ],
      ),
    );
  }

  Widget _buildBody(ProfileState profileState) {
    if (profileState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profileState.error!,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(profileControllerProvider.notifier).loadProfile();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final profile = profileState.profile;
    if (profile == null) {
      return const Center(child: Text('No profile data'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: profile.avatarUrl != null
                  ? NetworkImage(profile.avatarUrl!)
                  : null,
              child: profile.avatarUrl == null
                  ? Text(
                      profile.name.isNotEmpty
                          ? profile.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(fontSize: 36),
                    )
                  : null,
            ),
            const SizedBox(height: 24),

            // ── Form ────────────────────────────────────
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name row
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          controller: _firstNameController,
                          label: 'First name',
                          hint: 'John',
                          icon: Icons.person_outline,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildField(
                          controller: _lastNameController,
                          label: 'Last name',
                          hint: 'Doe',
                          icon: Icons.person_outline,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Email + phone row
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'john@email.com',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildField(
                          controller: _phoneController,
                          label: 'Phone number',
                          hint: '+1 555 000 0000',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          controller: _countryController,
                          label: 'Country',
                          hint: 'Colombia',
                          icon: Icons.place_outlined,
                          keyboardType: TextInputType.text,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildField(
                          controller: _cityController,
                          label: 'City',
                          hint: 'Cucuta',
                          icon: Icons.location_city,
                          keyboardType: TextInputType.text,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to edit profile page or show a dialog
                },
                style: ButtonStyle(
                  mouseCursor: WidgetStateProperty.all(
                    SystemMouseCursors.click,
                  ),
                  overlayColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.blue.withOpacity(0.8);
                    }
                    return null;
                  }),
                ),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}
