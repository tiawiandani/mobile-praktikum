# Pertemuan 04 — Flutter UI Fundamentals

## Identitas Mahasiswa

- Nama: Ni Made Tia Wiandani
- NIM: 2415051103
- Mata Kuliah: Pemrograman Mobile
- Materi: Flutter UI Fundamentals

## Learning Dashboard

Project ini merupakan implementasi Flutter UI Fundamentals berupa aplikasi **Learning Dashboard**.

### Fitur yang telah dibuat

- Menampilkan nama dan NIM mahasiswa.
- Menampilkan profile icon.
- Menampilkan total mata kuliah.
- Menampilkan total SKS.
- Menampilkan daftar mata kuliah dari data JSON.
- Menampilkan kode mata kuliah, jumlah SKS, dan kategori.
- Menampilkan status mata kuliah seperti Selesai dan Belum.
- Menggunakan reusable widget.
- Menggunakan StatefulWidget dan state.
- Menggunakan `FutureBuilder` untuk memuat data secara asynchronous.
- Menggunakan `rootBundle.loadString()` untuk membaca file JSON.
- Menggunakan `jsonDecode()` untuk mengubah JSON menjadi data Dart.
- Menggunakan `ListView` untuk menampilkan daftar mata kuliah.

## Data JSON

Data mata kuliah disimpan pada:

`assets/data/student_data.json`

Data tersebut berisi identitas mahasiswa dan 5 mata kuliah.

## Pengujian

Aplikasi berhasil dijalankan menggunakan:

```bash
flutter run -d chrome