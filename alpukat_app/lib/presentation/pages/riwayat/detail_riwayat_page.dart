import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// TODO Part 5: Lengkapi sama seperti HasilDeteksiPage
/// namun read-only + tombol hapus.
class DetailRiwayatPage extends StatelessWidget {
  final int id;
  const DetailRiwayatPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(title: const Text('Detail Riwayat')),
      body: Center(child: Text('Detail riwayat ID: $id')),
    );
  }
}
