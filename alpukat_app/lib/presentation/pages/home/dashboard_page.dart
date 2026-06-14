import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';

/// TODO Part 5: Lengkapi dengan stat cards, varietas info,
/// tingkat kematangan, dan riwayat terbaru sesuai Figma laporan.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final nama = authState is AuthAuthenticated ? authState.user.nama : 'Pengguna';

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: Text('Halo, $nama! 👋')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/home/deteksi'),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Deteksi Sekarang'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selamat datang di Alpukat CNN',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Dashboard lengkap akan ditampilkan di sini.',
              style: TextStyle(color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}
