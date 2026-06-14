import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// TODO Part 5: Lengkapi dengan 3 field password
/// dan integrasi PUT /api/user/password.
class GantiPasswordPage extends StatelessWidget {
  const GantiPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('Ganti Password')),
      body: const Center(child: Text('Form ganti password akan ditampilkan di sini.')),
    );
  }
}
