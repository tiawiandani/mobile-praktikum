# Catatan Implementasi UTS TaskMate

## 1. Identitas
- Nama: Ni Made Tia Wiandani
- NIM: 2415051103
- Program Studi: Pendidikan Teknik Informatika
- Kelas: 5B
- Universitas: Universitas Pendidikan Ganesha

## 2. Deskripsi Aplikasi
TaskMate merupakan aplikasi manajemen tugas perkuliahan berbasis Flutter. Aplikasi ini membantu pengguna menambahkan, melihat, mengubah, dan menghapus data tugas.

## 3. Teknologi
- Flutter dan Dart
- Provider dan ChangeNotifier
- Supabase
- HTTP
- JSON

## 4. Implementasi REST API
Aplikasi mengambil data dari JSONPlaceholder melalui endpoint:

https://jsonplaceholder.typicode.com/todos

Data JSON diubah menjadi objek Dart menggunakan model Task dan ditampilkan pada halaman REST API.

## 5. Backend dan Database
Aplikasi menggunakan Supabase sebagai backend dan penyimpanan data tugas.

Tabel yang digunakan: tasks.

Fitur database:
- Create: menambahkan tugas.
- Read: menampilkan daftar tugas.
- Update: mengubah tugas.
- Delete: menghapus tugas.

## 6. Arsitektur Aplikasi
Struktur kode dibagi menjadi:
- models: model data.
- services: komunikasi dengan REST API.
- repositories: pengelolaan sumber data.
- providers: state management.
- screens: halaman aplikasi.
- widgets: komponen antarmuka yang digunakan kembali.

## 7. Halaman Aplikasi
Aplikasi memiliki enam halaman utama:
1. Dashboard
2. Daftar tugas
3. Detail tugas
4. Tambah tugas
5. Edit tugas
6. REST API

## 8. Fitur Tambahan
- Navigasi antarhalaman.
- Validasi formulir.
- Konfirmasi sebelum menghapus tugas.
- Notifikasi menggunakan SnackBar.
- Loading, error, dan empty state.
- Tampilan responsif.

## 9. Repository GitHub
https://github.com/tiawiandani/mobile-praktikum.git

Branch: main

## 10. Catatan Pengujian
- REST API berhasil menampilkan data.
- CRUD Supabase telah diuji.
- Flutter analyze berhasil tanpa masalah.
- Flutter test berhasil menjalankan empat pengujian model.
- Tampilan responsif telah diperbaiki dan diperiksa.