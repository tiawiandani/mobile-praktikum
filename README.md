# TaskMate – Aplikasi Manajemen Tugas Mahasiswa

## Deskripsi Proyek

TaskMate merupakan aplikasi manajemen tugas mahasiswa berbasis Flutter yang dikembangkan untuk memenuhi tugas Ujian Tengah Semester (UTS) Pemrograman Mobile.

Aplikasi ini membantu mahasiswa mengelola tugas perkuliahan, mulai dari menambahkan, melihat, mengedit, hingga menghapus tugas. Data tugas disimpan secara permanen menggunakan Supabase.

## Tujuan

1. Mengembangkan aplikasi mobile menggunakan Flutter.
2. Menerapkan pengelolaan state menggunakan Provider dan ChangeNotifier.
3. Mengintegrasikan aplikasi dengan REST API.
4. Mengimplementasikan operasi CRUD menggunakan Supabase.
5. Menerapkan struktur proyek yang terorganisasi.

## Fitur Aplikasi

1. Dashboard profil mahasiswa.
2. Menampilkan daftar tugas.
3. Menambahkan tugas baru.
4. Melihat detail tugas.
5. Mengedit informasi tugas.
6. Menghapus tugas dengan konfirmasi.
7. Mengambil data dari REST API JSONPlaceholder.
8. Menyimpan data tugas secara permanen menggunakan Supabase.
9. Validasi formulir dan notifikasi SnackBar.

## Teknologi yang Digunakan

- Flutter
- Dart
- Provider
- Supabase
- PostgreSQL
- REST API
- JSONPlaceholder
- Git dan GitHub

## Struktur Folder

```text
lib/
├── models/
├── providers/
├── repositories/
├── screens/
├── services/
├── widgets/
└── main.dart
```

## Cara Menjalankan Aplikasi

Pastikan Flutter dan Dart sudah terpasang pada komputer.

1. Clone repository:

```bash
git clone https://github.com/tiawiandani/mobile-praktikum.git
```

2. Masuk ke folder proyek:

```bash
cd mobile-praktikum
```

3. Instal dependensi:

```bash
flutter pub get
```

4. Jalankan aplikasi:

```bash
flutter run
```

Untuk menjalankan melalui Chrome:

```bash
flutter run -d chrome
```

## Database

TaskMate menggunakan Supabase sebagai backend database dengan tabel `tasks`.

Data tugas meliputi:
- id
- title
- course
- description
- due_date
- status
- created_at

## REST API

Aplikasi menggunakan JSONPlaceholder sebagai sumber data REST API:

https://jsonplaceholder.typicode.com/todos

## Repository GitHub

https://github.com/tiawiandani/mobile-praktikum

---

**Proyek UTS Pemrograman Mobile – TaskMate**