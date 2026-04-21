# Kriteria Penilaian UTS — Pemrograman Mobile

---

## 1. Desain UI/UX & Mobile HCI (Cakupan P1 & P3)

- **Kenyamanan Navigasi (Thumb Zone):** Tombol aksi utama (FAB, Bottom Navigation) harus mudah dijangkau oleh ibu jari.
  > ✅ `FloatingActionButton` ditempatkan di `FloatingActionButtonLocation.centerDocked` (`nav_shell.dart` L38). `BottomAppBar` berada di bagian bawah layar (`nav_shell.dart` L40–L66), mudah dijangkau ibu jari.

- **SafeArea & Padding:** Tidak ada elemen UI yang tertutup oleh poni layar (notch), sensor kamera, atau terpotong di tepi layar (No Layout Overflow).
  > ✅ `SafeArea` digunakan di `order_screen.dart` L94 (membungkus body form). `bottomNavigationBar` di Scaffold otomatis menghindari system UI. `SliverAppBar` pinned mencegah konten tertutup di `home_screen.dart` L23–L52.

- **Tema Konsisten:** Menggunakan `ThemeData` global untuk mengatur warna utama, warna aksen, dan tipografi dasar secara seragam.
  > ✅ `ThemeData` lengkap didefinisikan di `main.dart` L20–L51, mencakup `colorScheme` (primary `0xFF2563EB`, secondary `0xFF10B981`), `AppBarTheme`, `CardTheme`, `ElevatedButtonTheme`, dan `InputDecorationTheme`.

---

## 2. Komposisi Layouting & Kontainer (Cakupan P3)

- Menggunakan kombinasi `Column` dan `Row` yang kompleks namun rapi.
  > ✅ `Column` + `Row` dikombinasikan di `detail_screen.dart` L66–L124 (kolom info layanan, baris rating). `Row` + `Column` di bottom bar `detail_screen.dart` L134–L163. `nav_shell.dart` L45–L65 (Row berisi 4 tab, tiap tab adalah Column ikon+label).

- Menggunakan `Expanded` atau `Flexible` untuk mencegah error kuning-hitam (RenderFlex overflow) pada layar berukuran kecil.
  > ✅ `Expanded` digunakan di `nav_shell.dart` L93 (tiap `_NavBtn` dalam Row), `detail_screen.dart` L153 (tombol "Pesan Sekarang"), `profile_screen.dart` L136 (kartu stat escrow), `service_card.dart` L32 (bagian konten bawah card).

- Implementasi minimal 1 elemen antarmuka yang saling bertumpuk menggunakan widget `Positioned` (misalnya: Lencana notifikasi di atas ikon, atau teks di atas gambar header).
  > ✅ Badge notifikasi angka "3" menggunakan `Stack` + `Positioned` di `nav_shell.dart` L103–L121. Badge merah bulat (`BoxShape.circle`) ditempatkan `top: -4, right: -6` di atas ikon notifikasi.

- Menggunakan dekorasi visual pada `Container` atau `Card` (seperti Border radius dan Box shadow).
  > ✅ `Container` dengan `BoxDecoration` + `borderRadius` + `border` di `order_screen.dart` L178–L184 (info escrow kuning) dan `detail_screen.dart` L172–L178 (banner escrow hijau). `Card` menggunakan `RoundedRectangleBorder` radius 16 via `CardTheme` di `main.dart` L33–L36. Gradient pada header di `home_screen.dart` L29–L34.

---

## 3. Tampilan Daftar Dinamis (Cakupan P4)

- Mengimplementasikan `ListView.builder` ATAU `GridView.builder` untuk menampilkan daftar data secara dinamis.
  > ✅ `SliverGrid.builder` di `home_screen.dart` L97–L106 dengan `itemCount: ServiceModel.dummyData.length` dan `itemBuilder: (_, i) => ServiceCard(service: ServiceModel.dummyData[i])`.

- Harus memuat minimal 10 data tiruan (dummy statis) dalam bentuk List atau Map di dalam kode.
  > ✅ `static final List<ServiceModel> dummyData` berisi **10 item** layanan (S001–S010) di `models/service.dart` L32–L103.

- Menggunakan `ListTile` atau rancangan Card kustom untuk setiap iterasi item di dalam list/grid.
  > ✅ `ServiceCard` adalah card kustom (`service_card.dart` L4–L89) dengan header emoji, kategori, judul, rating bintang, harga, dan tanda favorit. Ditampilkan per item di grid.

---

## 4. Navigasi & Routing Antar Halaman (Cakupan P4)

- Aplikasi harus memiliki minimal 3 halaman (screen) yang berbeda (contoh: Layar Home, Layar Detail Produk, dan Layar Profil/Keranjang).
  > ✅ Terdapat **4 halaman**: `HomeScreen` (`home_screen.dart`), `DetailScreen` (`detail_screen.dart`), `OrderScreen` (`order_screen.dart`), `ProfileScreen` (`profile_screen.dart`).

- Menggunakan `Navigator.push` dan `Navigator.pop` (atau Named Routes) untuk perpindahan layar.
  > ✅ Named Routes dengan `onGenerateRoute` di `main.dart` L53–L66. `Navigator.pushNamed(context, '/detail', arguments: service)` di `service_card.dart` L13. `Navigator.pushNamed(context, '/order', arguments: s)` di `detail_screen.dart` L156. `Navigator.pop(context)` di `order_screen.dart` L78–L79.

- **Kirim Data (Argument Passing):** Wajib ada mekanisme pengiriman data dari satu halaman ke halaman lain (misal: Menekan salah satu item berita di list Home, lalu judul dan isi berita tersebut muncul di halaman Detail).
  > ✅ Objek `ServiceModel` dikirim sebagai `arguments` saat `pushNamed`. Diterima di `main.dart` L57 (`settings.arguments as ServiceModel`) lalu diteruskan ke `DetailScreen` sebagai parameter `service`. Data (judul, harga, deskripsi, dll.) tampil di `detail_screen.dart` L78, L87, L107, L143.

- Menggunakan navigasi struktural permanen: `BottomNavigationBar` ATAU `Drawer`.
  > ✅ `BottomAppBar` permanen dengan 4 tab di `nav_shell.dart` L40–L66. Tab aktif dikendalikan `_index` via `setState`, halaman dirender dengan `IndexedStack` L28 agar state tiap tab tidak hilang.

---

## 5. Manajemen State Dasar & Form Validasi (Cakupan P3 & P4)

- **StatefulWidget:** Wajib memiliki interaksi dinamis yang mengubah UI menggunakan `setState()` (misalnya: tombol like yang berubah warna saat ditekan, atau counter jumlah keranjang).
  > ✅ Ikon favorit berubah warna merah/putih via `_toggleFavorite()` → `setState()` di `detail_screen.dart` L21–L30. Loading spinner muncul/hilang saat submit via `setState(() => _isLoading = ...)` di `order_screen.dart` L50, L53. Ganti tab di `nav_shell.dart` L32, L48, L60, L63.

- **Form & Validasi:** Terdapat minimal 1 formulir (Login, Registrasi, atau Tambah Data) yang menggunakan widget `Form` dan `TextFormField`.
  > ✅ Widget `Form` dengan `key: _formKey` di `order_screen.dart` L95–L96. Tiga `TextFormField`: nama (L115–L124), nomor HP (L128–L143), catatan opsional (L166–L174).

- Menggunakan `GlobalKey<FormState>` dengan minimal 2 aturan validasi (misal: input tidak boleh kosong dan minimal 6 karakter).
  > ✅ `final _formKey = GlobalKey<FormState>()` di `order_screen.dart` L13, dipakai di `_submit()` L40. **Validasi 1:** nama tidak boleh kosong (`v.trim().isEmpty`) → L122–L123. **Validasi 2:** nomor HP tidak kosong + minimal 9 digit → L136–L142.

- Menampilkan umpan balik (Feedback) kepada pengguna menggunakan `SnackBar` setelah aksi validasi berhasil dilakukan.
  > ✅ `showSnackBar` merah muncul jika tanggal belum dipilih (`order_screen.dart` L42–L47). `showSnackBar` floating muncul setelah toggle favorit (`detail_screen.dart` L25–L29). `showDialog` + `AlertDialog` "Pesanan Berhasil!" muncul setelah form valid dan submit sukses (`order_screen.dart` L56–L85).
