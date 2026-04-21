# 📱 SobatBeres — Marketplace Jasa

Aplikasi mobile marketplace jasa berbasis Flutter yang menghubungkan pengguna dengan penyedia layanan terpercaya. Dilengkapi sistem **escrow** untuk menjamin keamanan transaksi.

## 👥 Anggota Kelompok

| No | Nama | NPM |
|----|------|-----|
| 1 | Dennis Ardiyansyah | 24082010011 |
| 2 | Fatur Rachman P.N.E | 24082010021 |
| 3 | Rahimah | 24082010036 |
| 4 | Ahmad Zulfikar Ramdzi | 24082010039 |

## 📖 Alur Aplikasi

```
Beranda → Pilih Jasa → Detail Jasa → Form Pemesanan → Konfirmasi
```

### 1. Beranda (`HomeScreen`)
Halaman utama menampilkan daftar layanan dalam bentuk grid 2 kolom. Terdapat search bar untuk pencarian dan SliverAppBar dengan gradient biru yang collapse saat di-scroll.

### 2. Detail Jasa (`DetailScreen`)
Saat pengguna mengetuk kartu jasa, akan masuk ke halaman detail yang menampilkan:
- Emoji besar sebagai ikon jasa
- Informasi penyedia (nama, badge terverifikasi)
- Rating & jumlah ulasan
- Deskripsi lengkap layanan
- Banner keamanan escrow
- Tombol **favorit** (❤️) dan tombol **Pesan Sekarang**

### 3. Form Pemesanan (`OrderScreen`)
Form pemesanan dengan validasi input:
- **Nama Lengkap** — wajib diisi
- **Nomor HP** — minimal 9 digit
- **Tanggal Pengerjaan** — menggunakan date picker
- **Catatan** — opsional
- Tombol submit dengan loading indicator + dialog konfirmasi sukses

### 4. Profil (`ProfileScreen`)
Halaman profil menampilkan:
- Info pengguna (avatar, nama, email)
- Status escrow (aktif, selesai, dana aman)
- Riwayat pesanan dengan status (Selesai / Dana Ditahan)
- Menu pengaturan (Edit Profil, Notifikasi, Keamanan, Bantuan, Keluar)

### 5. Navigasi (`NavShell`)
Bottom navigation bar dengan 4 tab + FAB (Floating Action Button) di tengah:
- 🏠 Beranda
- 🔔 Notifikasi (dengan badge angka)
- 🛒 FAB — shortcut ke halaman pesanan
- 📋 Pesanan
- 👤 Profil

## 🏗️ Struktur Project

```
lib/
├── models/
│   └── service.dart          # Model data jasa (ServiceModel)
├── widgets/
│   ├── service_card.dart     # Widget kartu jasa (grid item)
│   └── nav_shell.dart        # Bottom navigation + FAB
├── screens/
│   ├── home_screen.dart      # Halaman utama + search + grid
│   ├── detail_screen.dart    # Detail jasa + favorit + escrow
│   ├── order_screen.dart     # Form pemesanan + validasi
│   └── profile_screen.dart   # Profil + riwayat + pengaturan
└── main.dart                 # Entry point, tema, routing
```

## 🚀 Cara Menjalankan

```bash
# Clone repository
git clone https://github.com/annisa-nursajidah/ut_mobile_uts.git

# Masuk ke folder project
cd ut_mobile_uts

# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run
```

## 📸 Screenshot Aplikasi

![Screenshot 1](foto/WhatsApp%20Image%202026-04-21%20at%2008.25.40.jpeg)

![Screenshot 2](foto/WhatsApp%20Image%202026-04-21%20at%2008.25.53.jpeg)

![Screenshot 3](foto/WhatsApp%20Image%202026-04-21%20at%2008.26.07.jpeg)
