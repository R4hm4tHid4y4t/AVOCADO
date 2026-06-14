-- ============================================================
-- DATABASE: alpukat_cnn_db
-- Project : Klasifikasi Varietas & Deteksi Kematangan Alpukat
-- Author  : Rahmat Hidayat (2311081030), Politeknik Negeri Padang
-- Engine  : InnoDB | Charset: utf8mb4
-- ============================================================

CREATE DATABASE IF NOT EXISTS alpukat_cnn_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE alpukat_cnn_db;

-- ── 1. USERS ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id                 INT            NOT NULL AUTO_INCREMENT,
  nama               VARCHAR(100)   NOT NULL,
  email              VARCHAR(100)   NOT NULL,
  password           VARCHAR(255)   NOT NULL,
  role               VARCHAR(20)    NOT NULL DEFAULT 'pengguna',
  status_verifikasi  TINYINT(1)     NOT NULL DEFAULT 0,
  foto_profil        VARCHAR(255)       NULL,
  created_at         TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMP          NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE  KEY uq_users_email (email),
  INDEX        idx_users_email (email),
  INDEX        idx_users_role  (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 2. OTP VERIFIKASI ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS otp_verifikasi (
  id               INT          NOT NULL AUTO_INCREMENT,
  user_id          INT          NOT NULL,
  kode_otp         VARCHAR(6)   NOT NULL,
  tipe             VARCHAR(20)  NOT NULL COMMENT 'verifikasi | reset',
  status_digunakan TINYINT(1)   NOT NULL DEFAULT 0,
  expired_at       DATETIME     NOT NULL,
  created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  INDEX idx_otp_user_id (user_id),
  CONSTRAINT fk_otp_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 3. PROFIL PENGGUNA ────────────────────────────────────
CREATE TABLE IF NOT EXISTS profil_pengguna (
  id           INT          NOT NULL AUTO_INCREMENT,
  user_id      INT          NOT NULL,
  bio          TEXT             NULL,
  no_telepon   VARCHAR(15)      NULL,
  updated_at   TIMESTAMP        NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_profil_user_id (user_id),
  CONSTRAINT fk_profil_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 4. VARIETAS ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS varietas (
  id               INT          NOT NULL AUTO_INCREMENT,
  nama_varietas    VARCHAR(100) NOT NULL,
  deskripsi        TEXT             NULL,
  gambar_referensi VARCHAR(255)     NULL,
  created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at       TIMESTAMP        NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_varietas_nama (nama_varietas)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 5. TINGKAT KEMATANGAN ─────────────────────────────────
CREATE TABLE IF NOT EXISTS tingkat_kematangan (
  id               INT          NOT NULL AUTO_INCREMENT,
  label_kematangan VARCHAR(50)  NOT NULL,
  deskripsi        TEXT             NULL,
  ciri_visual      VARCHAR(255)     NULL,
  created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at       TIMESTAMP        NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_kematangan_label (label_kematangan)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 6. MODEL CNN ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS model_cnn (
  id           INT           NOT NULL AUTO_INCREMENT,
  versi        VARCHAR(20)   NOT NULL,
  akurasi      DECIMAL(5,2)      NULL,
  format_file  VARCHAR(10)   NOT NULL DEFAULT 'tflite',
  deskripsi    TEXT              NULL,
  status_aktif TINYINT(1)    NOT NULL DEFAULT 0,
  uploaded_by  INT               NULL,
  created_at   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   TIMESTAMP         NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_model_uploader FOREIGN KEY (uploaded_by)
    REFERENCES users (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 7. HASIL DETEKSI ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS hasil_deteksi (
  id                    INT          NOT NULL AUTO_INCREMENT,
  user_id               INT          NOT NULL,
  model_id              INT              NULL,
  varietas_id           INT              NULL,
  kematangan_id         INT              NULL,
  gambar_input          VARCHAR(255)     NULL,
  confidence_varietas   DECIMAL(5,2)     NULL,
  confidence_kematangan DECIMAL(5,2)     NULL,
  status_flag           VARCHAR(20)  NOT NULL DEFAULT 'normal',
  catatan_flag          TEXT             NULL,
  created_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  INDEX idx_hasil_user_id    (user_id),
  INDEX idx_hasil_created_at (created_at),
  INDEX idx_hasil_status_flag(status_flag),
  CONSTRAINT fk_hasil_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_hasil_model FOREIGN KEY (model_id)
    REFERENCES model_cnn (id) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_hasil_varietas FOREIGN KEY (varietas_id)
    REFERENCES varietas (id) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_hasil_kematangan FOREIGN KEY (kematangan_id)
    REFERENCES tingkat_kematangan (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 8. RIWAYAT DETEKSI ────────────────────────────────────
CREATE TABLE IF NOT EXISTS riwayat_deteksi (
  id         INT         NOT NULL AUTO_INCREMENT,
  user_id    INT         NOT NULL,
  hasil_id   INT         NOT NULL,
  aksi       VARCHAR(50) NOT NULL COMMENT 'deteksi | simpan | bagikan | ditandai_admin',
  created_at TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  INDEX idx_riwayat_user_id  (user_id),
  INDEX idx_riwayat_hasil_id (hasil_id),
  CONSTRAINT fk_riwayat_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_riwayat_hasil FOREIGN KEY (hasil_id)
    REFERENCES hasil_deteksi (id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
