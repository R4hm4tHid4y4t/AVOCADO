-- ============================================================
-- SEEDER DATA AWAL
-- Jalankan SETELAH alpukat_cnn_db.sql
-- ============================================================

USE alpukat_cnn_db;

-- ── ADMIN DEFAULT ─────────────────────────────────────────
-- Password: Admin@123 (bcrypt hash)
INSERT INTO users (nama, email, password, role, status_verifikasi) VALUES
('Admin Sistem', 'admin@alpukat.id',
 '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMaUMCBSiUqznUR1mq3YWbcTCe',
 'admin', 1)
ON DUPLICATE KEY UPDATE nama = VALUES(nama);

-- Profil admin
INSERT INTO profil_pengguna (user_id, bio) VALUES
(1, 'Administrator sistem Alpukat CNN')
ON DUPLICATE KEY UPDATE bio = VALUES(bio);

-- ── VARIETAS ──────────────────────────────────────────────
INSERT INTO varietas (nama_varietas, deskripsi) VALUES
('Aligator',
 'Alpukat Aligator memiliki kulit kasar dan bertekstur menyerupai kulit buaya. Buah berukuran besar dengan daging tebal berwarna kuning kehijauan. Cocok untuk konsumsi langsung maupun diolah menjadi jus.'),
('Miki',
 'Alpukat Miki merupakan varietas lokal Indonesia dengan kulit halus dan mengkilap. Ukuran buah sedang dengan rasa yang gurih dan creamy. Salah satu varietas alpukat unggulan di Sumatera Barat.')
ON DUPLICATE KEY UPDATE deskripsi = VALUES(deskripsi);

-- ── TINGKAT KEMATANGAN (4 kelas sesuai model CNN) ─────────
INSERT INTO tingkat_kematangan (label_kematangan, deskripsi, ciri_visual) VALUES
('Mentah',
 'Buah alpukat dalam kondisi mentah, belum siap untuk dikonsumsi. Perlu waktu beberapa hari lagi untuk matang.',
 'Kulit berwarna hijau cerah dan keras saat ditekan. Tidak ada perubahan warna pada kulit buah.'),
('Setengah Matang',
 'Buah alpukat dalam kondisi setengah matang. Mendekati kesiapan konsumsi namun sebaiknya ditunggu 1-3 hari lagi.',
 'Kulit mulai melunak, warna berubah menjadi hijau kecoklatan. Sedikit lunak saat ditekan di bagian tertentu.'),
('Matang',
 'Buah alpukat dalam kondisi matang sempurna dan siap dikonsumsi. Kualitas rasa dan tekstur terbaik.',
 'Kulit lunak merata saat ditekan, warna gelap kehitaman merata. Daging berwarna kuning keemasan dengan tekstur creamy.'),
('Terlalu Matang',
 'Buah alpukat dalam kondisi terlalu matang. Segera konsumsi atau olah menjadi produk seperti jus atau guacamole.',
 'Kulit sangat lunak dan mudah penyok, warna sangat gelap hampir hitam. Mungkin terdapat bercak hitam pada daging.')
ON DUPLICATE KEY UPDATE deskripsi = VALUES(deskripsi), ciri_visual = VALUES(ciri_visual);

-- ── MODEL CNN ─────────────────────────────────────────────
INSERT INTO model_cnn (versi, akurasi, format_file, deskripsi, status_aktif, uploaded_by) VALUES
('v1.0-varietas',   100.00, 'tflite',
 'Model MobileNetV2 untuk klasifikasi varietas alpukat. Akurasi 100% pada data test (32 sampel). Dilatih pada 27 April 2026.',
 1, 1),
('v1.0-kematangan', 84.38,  'tflite',
 'Model MobileNetV2 untuk deteksi kematangan alpukat (4 kelas). Akurasi 84.38% pada data test (27/32 sampel). Kelemahan pada kelas Setengah Matang (37.5%). Dilatih pada 27 April 2026.',
 1, 1)
ON DUPLICATE KEY UPDATE deskripsi = VALUES(deskripsi);
