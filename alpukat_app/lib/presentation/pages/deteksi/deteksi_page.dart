import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// TODO Part 5: Lengkapi dengan image picker (kamera/galeri),
/// preview gambar, tombol analisis, dan integrasi DeteksiBloc.
class DeteksiPage extends StatelessWidget {
  const DeteksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('Deteksi Alpukat')),
      body: const Center(
        child: Text('Halaman deteksi akan ditampilkan di sini.'),
      ),
    );
  }
}
