import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// TODO Part 5: Lengkapi dengan card varietas, card kematangan,
/// confidence bar, rekomendasi konsumsi, dan tombol aksi.
class HasilDeteksiPage extends StatelessWidget {
  final Map<String, dynamic> hasil;
  const HasilDeteksiPage({super.key, required this.hasil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('Hasil Deteksi')),
      body: Center(
        child: Text('Hasil: ${hasil.toString()}'),
      ),
    );
  }
}
