import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// TODO Part 5: Lengkapi dengan stat row, filter chips,
/// infinite scroll, swipe-to-delete, dan integrasi RiwayatBloc.
class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('Riwayat Deteksi')),
      body: const Center(
        child: Text('Daftar riwayat akan ditampilkan di sini.'),
      ),
    );
  }
}
