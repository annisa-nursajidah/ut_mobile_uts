# 📱 Dokumentasi Teknis Implementasi — SobatBeres

> **Aplikasi:** SobatBeres — Marketplace Jasa Lokal  
> **Framework:** Flutter (Dart) · Material 3  
> **Versi Dokumen:** 1.0 · 21 April 2026

Dokumen ini menjelaskan secara lengkap bagaimana **setiap kriteria penilaian** diimplementasikan dalam project SobatBeres, disertai lokasi file, nomor baris, dan cuplikan kode yang relevan.

---

## Daftar Isi

1. [Desain UI/UX & Mobile HCI](#1-desain-uiux--mobile-hci)  
2. [Komposisi Layouting & Kontainer](#2-komposisi-layouting--kontainer)  
3. [Tampilan Daftar Dinamis](#3-tampilan-daftar-dinamis)  
4. [Navigasi & Routing Antar Halaman](#4-navigasi--routing-antar-halaman)  
5. [Manajemen State & Form Validasi](#5-manajemen-state--form-validasi)  
6. [Struktur File Proyek](#6-struktur-file-proyek)

---

## 1. Desain UI/UX & Mobile HCI

> **Cakupan P1 & P3**

### 1.1 Kenyamanan Navigasi — Thumb Zone

Tombol aksi utama ditempatkan di **area bawah layar** sehingga mudah dijangkau ibu jari tanpa memindahkan genggaman.

| Widget | File | Baris | Keterangan |
|--------|------|-------|------------|
| `FloatingActionButton` | `lib/widgets/nav_shell.dart` | 30–45 | Shortcut "Pesan Jasa" di area tengah bawah |
| `floatingActionButtonLocation` | `lib/widgets/nav_shell.dart` | 46 | Nilai `centerDocked` — FAB menempel di tengah bottom bar |
| `BottomAppBar` (4 tab) | `lib/widgets/nav_shell.dart` | 48–87 | Navigasi utama di tepi bawah layar |
| Tombol "Pesan Sekarang" | `lib/screens/detail_screen.dart` | 131–163 | Sticky bottom bar, selalu di area ibu jari |

**Cuplikan kode — nav_shell.dart:**
```dart
// FAB di tengah bawah, mudah dijangkau ibu jari
floatingActionButton: FloatingActionButton(
  onPressed: () { ... },
  backgroundColor: Theme.of(context).colorScheme.secondary,
  tooltip: 'Pesan Jasa',
  child: const Icon(Icons.add_shopping_cart_rounded),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // thumb zone
```

---

### 1.2 SafeArea & Padding — No Layout Overflow

Setiap layar memastikan konten tidak tertutup oleh *notch*, *status bar*, *gesture bar*, atau tepi layar.

| Aspek | File | Baris | Keterangan |
|-------|------|-------|------------|
| `SafeArea` body — form tidak tertutup notch | `lib/screens/order_screen.dart` | 94 | Membungkus seluruh `Form` + `ListView` |
| `SafeArea` bottom bar — tombol tidak tertutup gesture bar | `lib/screens/detail_screen.dart` | 131 | Membungkus row harga + tombol CTA |
| `SliverAppBar` pinned — konten tidak tertutup AppBar saat scroll | `lib/screens/home_screen.dart` | 23–52 | `pinned: true` agar AppBar tetap tampil |
| Bottom padding `100` — konten grid tidak tertutup bottom bar | `lib/screens/home_screen.dart` | 96 | `EdgeInsets.fromLTRB(16, 0, 16, 100)` |
| Bottom spacing `SizedBox(height: 100)` | `lib/screens/detail_screen.dart` | 122 | Konten tidak terpotong di belakang bottom bar |
| Bottom spacing `SizedBox(height: 80)` | `lib/screens/profile_screen.dart` | 111 | Konten terakhir tidak tertutup bottom bar |
| `BottomAppBar` `height: 60` eksplisit | `lib/widgets/nav_shell.dart` | 51 | Tinggi tetap, tidak overflow sistem |
| Komentar teknis alasan tidak pakai SafeArea di NavShell | `lib/widgets/nav_shell.dart` | 24–25 | Scaffold otomatis handle system UI |

**Cuplikan kode — order_screen.dart:**
```dart
body: SafeArea(       // ← mencegah form tertutup notch kamera
  child: Form(
    key: _formKey,
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [ ... ],
    ),
  ),
),
```

**Cuplikan kode — detail_screen.dart:**
```dart
bottomNavigationBar: SafeArea(   // ← tombol tidak tertutup home gesture bar
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
    child: Row( ... ),
  ),
),
```

---

### 1.3 Tema Konsisten — ThemeData Global

Satu sumber kebenaran (*single source of truth*) untuk seluruh warna, tipografi, dan bentuk komponen. Semua widget mengambil nilai dari `Theme.of(context)` tanpa mendefinisikan warna hardcode sendiri.

**File:** `lib/main.dart` · **Baris:** 20–51

```dart
static const _primary   = Color(0xFF2563EB); // biru cerah
static const _secondary = Color(0xFF10B981); // hijau emerald

theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primary,
    primary: _primary,      // warna utama
    secondary: _secondary,  // warna aksen
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: _primary,
    foregroundColor: Colors.white,
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primary,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16, vertical: 14,
    ),
  ),
),
```

| Token Tema | Nilai | Dipakai Di |
|------------|-------|------------|
| `primary` | `#2563EB` (biru) | AppBar, tombol, link, badge aktif |
| `secondary` | `#10B981` (hijau) | FAB, escrow banner, badge verified |
| Card `borderRadius` | `16` | Semua `Card` otomatis |
| Button `borderRadius` | `12` | Semua `ElevatedButton` otomatis |
| Input `borderRadius` | `12` | Semua `TextFormField` otomatis |

---

## 2. Komposisi Layouting & Kontainer

> **Cakupan P3**

### 2.1 Kombinasi Column & Row yang Kompleks

Struktur tata letak bersarang digunakan secara konsisten di semua layar.

| Struktur | File | Baris | Deskripsi |
|----------|------|-------|-----------|
| `Column` dalam `FlexibleSpaceBar` | `home_screen.dart` | 36–48 | Salam + subjudul di header animasi |
| `Row` section header | `home_screen.dart` | 80–88 | Judul "Semua Layanan" + counter |
| `Column` + `Stack` di `_NavBtn` | `nav_shell.dart` | 120–151 | Ikon bertumpuk (badge) + label |
| `Row` berisi 4 `_NavBtn` | `nav_shell.dart` | 53–86 | Tab bar horizontal |
| `Row` + `Column` bottom bar Detail | `detail_screen.dart` | 134–161 | Kolom harga + tombol `Expanded` |
| `Row` rating | `detail_screen.dart` | 82–90 | Ikon bintang + teks rating ulasan |
| `Row` escrow banner | `detail_screen.dart` | 179–189 | Ikon shield + teks `Expanded` |
| `Row` 3× `_EscrowStat` | `profile_screen.dart` | 66–78 | Stat Aktif / Selesai / Dana Aman |
| `Column` dalam `_EscrowStat` | `profile_screen.dart` | 144–153 | Ikon + nilai + label |
| `Column` dalam `ServiceCard` | `service_card.dart` | 15–84 | Header emoji + konten `Expanded` |
| `Row` rating di `ServiceCard` | `service_card.dart` | 56–65 | Ikon bintang + teks rating |
| `Row` info escrow OrderScreen | `order_screen.dart` | 185–196 | Ikon info + teks `Expanded` |

---

### 2.2 Expanded & Flexible — Mencegah RenderFlex Overflow

Widget `Expanded` digunakan secara **strategis** di setiap `Row` / `Column` yang berpotensi meluap pada layar kecil.

| Lokasi | File | Baris | Fungsi |
|--------|------|-------|--------|
| Tiap `_NavBtn` dalam `Row` tab | `nav_shell.dart` | 114 | Bagi lebar rata 4 tab |
| Tombol "Pesan Sekarang" | `detail_screen.dart` | 153 | Tombol mengisi sisa lebar setelah harga |
| Teks escrow banner | `detail_screen.dart` | 183 | Teks wrapping tidak overflow ke kanan |
| Teks escrow info | `order_screen.dart` | 190 | Teks wrapping tidak overflow ke kanan |
| Tiap `_EscrowStat` | `profile_screen.dart` | 136 | Bagi lebar rata 3 stat card |
| Konten bawah `ServiceCard` | `service_card.dart` | 32 | Mengisi sisa tinggi setelah header emoji |
| `Spacer()` dalam `ServiceCard` | `service_card.dart` | 53 | Push rating & harga ke bawah card |

**Contoh krusial — detail_screen.dart:**
```dart
Row(
  children: [
    Column(            // ← harga, ukuran shrink
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Harga mulai', ...),
        Text('Rp ${s.formattedPrice}', ...),
      ],
    ),
    const SizedBox(width: 16),
    Expanded(          // ← tombol mengisi sisa lebar → NO OVERFLOW
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/order', arguments: s),
        child: const Text('Pesan Sekarang'),
      ),
    ),
  ],
),
```

---

### 2.3 Stack & Positioned — Elemen Bertumpuk

> ✅ Implementasi: **Badge (lencana) notifikasi bertumpuk di atas ikon 🔔**

**File:** `lib/widgets/nav_shell.dart` · **Baris:** 124–142

```dart
Stack(
  clipBehavior: Clip.none,   // badge bisa keluar batas ikon
  children: [
    Icon(icon, color: color),             // ← ikon utama (lapisan bawah)
    if (badgeCount > 0)
      Positioned(
        top: -4, right: -6,               // ← pojok kanan atas ikon
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,       // ← lingkaran merah
          ),
          child: Text(
            '$badgeCount',                // ← angka "3"
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
  ],
),
```

**Yang terlibat:**
- `Stack` dengan `clipBehavior: Clip.none` → badge tidak terpotong batas widget
- `Positioned(top: -4, right: -6)` → posisi tepat di sudut kanan atas ikon
- `BoxShape.circle` + `Colors.red` → tampilan badge notifikasi standar

---

### 2.4 Dekorasi Visual — Border Radius & Box Shadow

| Komponen | Dekorasi | File | Baris |
|----------|----------|------|-------|
| Semua `Card` (global) | `elevation: 2` + `borderRadius: 16` | `main.dart` | 33–36 |
| Semua `ElevatedButton` (global) | `borderRadius: 12` | `main.dart` | 42 |
| Semua `TextFormField` (global) | `borderRadius: 12` | `main.dart` | 48 |
| Header emoji `ServiceCard` | `borderRadius: vertical(top: 16)` | `service_card.dart` | 22–25 |
| Banner escrow Detail | `borderRadius: 12` + `border` hijau | `detail_screen.dart` | 174–178 |
| Banner escrow Order | `borderRadius: 12` + `border` oranye | `order_screen.dart` | 180–184 |
| Stat card `_EscrowStat` | `borderRadius: 12` + `border` dinamis | `profile_screen.dart` | 139–143 |
| Badge notifikasi | `BoxShape.circle` | `nav_shell.dart` | 133–134 |
| Dialog sukses pesanan | `borderRadius: 20` | `order_screen.dart` | 59 |
| Header gradient `HomeScreen` | `LinearGradient` biru | `home_screen.dart` | 29–34 |
| Header gradient `ProfileScreen` | `LinearGradient` biru | `profile_screen.dart` | 27–33 |

**Contoh dekorasi Container — order_screen.dart:**
```dart
Container(
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
    color: const Color(0xFFFFFBEB),               // kuning muda
    borderRadius: BorderRadius.circular(12),       // sudut membulat
    border: Border.all(
      color: Colors.orange.withAlpha(80),          // border oranye transparan
    ),
  ),
  child: Row( ... ),   // ikon info + teks escrow
),
```

---

## 3. Tampilan Daftar Dinamis

> **Cakupan P4**

### 3.1 SliverGrid.builder (GridView Dinamis)

**File:** `lib/screens/home_screen.dart` · **Baris:** 94–107

```dart
SliverPadding(
  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
  sliver: SliverGrid.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,       // 2 kolom
      mainAxisSpacing: 14,     // jarak vertikal antar item
      crossAxisSpacing: 14,    // jarak horizontal antar item
      childAspectRatio: 0.78,  // rasio lebar:tinggi tiap cell
    ),
    itemCount: ServiceModel.dummyData.length,               // = 10
    itemBuilder: (_, i) => ServiceCard(service: ServiceModel.dummyData[i]),
  ),
),
```

- `itemCount` mengambil panjang list secara dinamis → otomatis menyesuaikan jika data ditambah
- `itemBuilder` menerima indeks `i` dan membangun `ServiceCard` per item
- Menggunakan `SliverGrid.builder` agar terintegrasi mulus dengan `CustomScrollView` + `SliverAppBar`

---

### 3.2 Data Dummy Statis — 10 Item

**File:** `lib/models/service.dart` · **Baris:** 32–103

```dart
static final List<ServiceModel> dummyData = [
  ServiceModel( id: 'S001', ... ),
  ServiceModel( id: 'S002', ... ),
  ...  // dst.
];
```

| No | ID | Judul Layanan | Kategori | Harga | Rating |
|----|----|---------------|----------|-------|--------|
| 1 | S001 | Bersih-Bersih Rumah | Kebersihan | Rp 150.000 | ⭐ 4.8 |
| 2 | S002 | Servis AC Split & Cuci | Elektronik | Rp 200.000 | ⭐ 4.9 |
| 3 | S003 | Les Privat Matematika | Pendidikan | Rp 100.000 | ⭐ 4.7 |
| 4 | S004 | Desain Logo & Branding | Desain | Rp 350.000 | ⭐ 4.6 |
| 5 | S005 | Pijat Panggilan Terapis | Kesehatan | Rp 180.000 | ⭐ 4.5 |
| 6 | S006 | Cuci Motor & Mobil | Otomotif | Rp 50.000 | ⭐ 4.4 |
| 7 | S007 | Instalasi & Servis Listrik | Teknik | Rp 120.000 | ⭐ 4.8 |
| 8 | S008 | Foto Produk UMKM | Fotografi | Rp 250.000 | ⭐ 4.7 |
| 9 | S009 | Antar Barang Dalam Kota | Logistik | Rp 25.000 | ⭐ 4.3 |
| 10 | S010 | Pembuatan Website Bisnis | IT & Digital | Rp 1.500.000 | ⭐ 4.9 |

---

### 3.3 Card Kustom & ListTile per Item

#### ServiceCard (Grid Item Utama)

**File:** `lib/widgets/service_card.dart` · **Baris:** 4–89

Setiap item di grid dibungkus dalam `Card` kustom dengan komponen:

| Elemen | Widget | Baris |
|--------|--------|-------|
| Wadah luar | `Card` dari tema global | 14 |
| Header emoji | `Container` dengan `boxDecoration` gradient | 19–29 |
| Label kategori | `Text` dengan warna primary | 39–43 |
| Judul layanan | `Text` max 2 baris + `overflow: ellipsis` | 47–51 |
| Push ke bawah | `Spacer()` | 53 |
| Rating bintang | `Row` ikon + teks | 56–65 |
| Harga | `Text` tebal warna primary | 70–74 |
| Tanda favorit | `Text` merah, muncul kondisional | 77–79 |

```dart
Card(
  // border radius & shadow dari CardTheme global (main.dart L33-36)
  child: Column(
    children: [
      // Header emoji
      Container(
        height: 90,
        decoration: BoxDecoration(
          color: primary.withAlpha(25),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Text(service.emoji, style: const TextStyle(fontSize: 40)),
      ),
      // Konten bawah — Expanded mencegah overflow
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(service.category, ...),   // kategori
              Text(service.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              const Spacer(),                // push rating ke bawah
              Row(/* rating bintang */),
              Text('Rp ${service.formattedPrice}', ...),
            ],
          ),
        ),
      ),
    ],
  ),
),
```

#### ListTile di Layar Lain

| Penggunaan | File | Baris |
|------------|------|-------|
| Ringkasan jasa yang dipesan | `order_screen.dart` | 103–109 |
| Info penyedia jasa | `detail_screen.dart` | 94–109 |
| Riwayat pesanan `_OrderCard` | `profile_screen.dart` | 170–181 |
| Menu pengaturan `_MenuItem` | `profile_screen.dart` | 194–200 |

---

## 4. Navigasi & Routing Antar Halaman

> **Cakupan P4**

### 4.1 Minimal 3 Halaman — Terdapat 4 Screen

| # | Screen | File | Deskripsi |
|---|--------|------|-----------|
| 1 | **HomeScreen** | `lib/screens/home_screen.dart` | Grid semua layanan, search bar, header animasi |
| 2 | **DetailScreen** | `lib/screens/detail_screen.dart` | Detail layanan, rating, deskripsi, CTA pesan |
| 3 | **OrderScreen** | `lib/screens/order_screen.dart` | Form pemesanan dengan validasi & escrow info |
| 4 | **ProfileScreen** | `lib/screens/profile_screen.dart` | Profil pengguna, stat escrow, riwayat pesanan |
| — | **NavShell** | `lib/widgets/nav_shell.dart` | Pembungkus navigasi + BottomAppBar + FAB |

---

### 4.2 Navigator.pushNamed & Named Routes

**File:** `lib/main.dart` · **Baris:** 53–66

```dart
onGenerateRoute: (settings) {
  switch (settings.name) {
    case '/detail':
      return MaterialPageRoute(
        builder: (_) => DetailScreen(
          service: settings.arguments as ServiceModel,  // terima argumen
        ),
      );
    case '/order':
      return MaterialPageRoute(
        builder: (_) => OrderScreen(
          service: settings.arguments as ServiceModel?, // terima argumen
        ),
      );
    default:
      return null;
  }
},
```

| Aksi Navigasi | Kode | File | Baris |
|---------------|------|------|-------|
| Home → Detail (tap card) | `Navigator.pushNamed(context, '/detail', arguments: service)` | `service_card.dart` | 13 |
| Detail → Order (tap "Pesan") | `Navigator.pushNamed(context, '/order', arguments: s)` | `detail_screen.dart` | 155–156 |
| Order → kembali (sukses) | `Navigator.pop(context)` × 2 | `order_screen.dart` | 78–79 |

---

### 4.3 Argument Passing — Kirim Data Antar Halaman

Data `ServiceModel` mengalir melalui **3 lapisan halaman**:

```
HomeScreen
    │
    │  [tap ServiceCard]
    │  Navigator.pushNamed('/detail', arguments: service)
    ▼
DetailScreen (menerima: widget.service)
    │  → Tampilkan: judul, harga, rating, deskripsi, provider
    │
    │  [tap "Pesan Sekarang"]
    │  Navigator.pushNamed('/order', arguments: s)
    ▼
OrderScreen (menerima: widget.service)
    │  → Tampilkan ringkasan: emoji, judul, provider, harga
    │
    │  [submit berhasil]
    │  Navigator.pop() × 2
    ▼
(kembali ke HomeScreen)
```

**Pengiriman data di service_card.dart:**
```dart
GestureDetector(
  onTap: () => Navigator.pushNamed(
    context,
    '/detail',
    arguments: service,  // kirim objek ServiceModel lengkap
  ),
  child: Card( ... ),
),
```

**Penerimaan di DetailScreen:**
```dart
class DetailScreen extends StatefulWidget {
  final ServiceModel service;  // terima sebagai parameter

  @override
  Widget build(BuildContext context) {
    final s = widget.service;
    Text(s.title, ...);         // pakai data yang dikirim
    Text('Rp ${s.formattedPrice}', ...);
    Text(s.description, ...);
  }
}
```

---

### 4.4 BottomNavigationBar Permanen — NavShell

**File:** `lib/widgets/nav_shell.dart`

```dart
// IndexedStack: pertahankan state tiap tab saat ganti halaman
body: IndexedStack(index: _index, children: _screens),  // L28

bottomNavigationBar: BottomAppBar(
  shape: const CircularNotchedRectangle(),  // notch untuk FAB
  notchMargin: 8,
  height: 60,
  child: Row(
    children: [
      _NavBtn(label: 'Beranda',    selected: _index == 0, onTap: () => setState(() => _index = 0)),
      _NavBtn(label: 'Notifikasi', selected: false, badgeCount: 3, ...),
      const SizedBox(width: 48),  // ruang FAB
      _NavBtn(label: 'Pesanan',   selected: false, ...),
      _NavBtn(label: 'Profil',    selected: _index == 1, onTap: () => setState(() => _index = 1)),
    ],
  ),
),
```

| Tab | Ikon | Perilaku |
|-----|------|----------|
| Beranda | `Icons.home_outlined` | Tampil `HomeScreen` |
| Notifikasi 🔴3 | `Icons.notifications_none` | Tampil SnackBar "3 notifikasi baru" |
| Pesanan | `Icons.receipt_long_outlined` | Arahkan ke Beranda + info |
| Profil | `Icons.person_outline` | Tampil `ProfileScreen` |

---

## 5. Manajemen State & Form Validasi

> **Cakupan P3 & P4**

### 5.1 StatefulWidget & setState()

Tiga `StatefulWidget` dengan interaksi dinamis berbeda:

#### a) NavShell — Ganti Tab Aktif

**File:** `lib/widgets/nav_shell.dart` · **Baris:** 12–88

```dart
class _NavShellState extends State<NavShell> {
  int _index = 0;  // state tab aktif

  // Setiap tap tab → setState → IndexedStack re-render tab baru
  _NavBtn(
    onTap: () => setState(() => _index = 0),  // pindah ke Beranda
    selected: _index == 0,                    // ubah warna ikon aktif
  ),
}
```

**Efek visual:** Warna ikon & label berubah (biru = aktif, abu = tidak aktif) saat tab ditekan.

#### b) DetailScreen — Tombol Favorit Berubah Warna

**File:** `lib/screens/detail_screen.dart` · **Baris:** 12–30

```dart
class _DetailScreenState extends State<DetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.service.isFavorite;  // inisialisasi dari model
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);  // toggle state
    widget.service.isFavorite = _isFavorite;     // update model

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_isFavorite ? '❤️ Ditambahkan ke favorit' : 'Dihapus dari favorit'),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    ));
  }
}
```

**Efek visual:** Ikon hati berubah `Icons.favorite` (merah) ↔ `Icons.favorite_border` (putih) saat ditekan.

#### c) OrderScreen — Loading Spinner saat Submit

**File:** `lib/screens/order_screen.dart` · **Baris:** 38–86

```dart
bool _isLoading = false;

Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;
  setState(() => _isLoading = true);           // tampilkan spinner
  await Future.delayed(const Duration(seconds: 2));
  setState(() => _isLoading = false);          // sembunyikan spinner
  showDialog( ... );  // tampilkan dialog sukses
}

// Tombol berubah antara teks dan spinner
ElevatedButton(
  onPressed: _isLoading ? null : _submit,
  child: _isLoading
      ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
      : const Text('Konfirmasi & Bayar via Escrow'),
),
```

**Efek visual:** Tombol submit berubah menjadi spinner saat proses berlangsung, kemudian muncul dialog sukses.

---

### 5.2 Form & Validasi — GlobalKey\<FormState\>

**File:** `lib/screens/order_screen.dart`

```dart
final _formKey = GlobalKey<FormState>();  // L13 — kunci unik form
```

Widget `Form` membungkus seluruh field:

```dart
Form(
  key: _formKey,           // L96 — terhubung ke GlobalKey
  child: ListView(
    children: [
      TextFormField( ... ),  // field nama
      TextFormField( ... ),  // field HP
      TextFormField( ... ),  // field catatan (opsional)
    ],
  ),
),
```

#### Aturan Validasi

| # | Field | Aturan | Kode | Baris |
|---|-------|--------|------|-------|
| 1 | Nama Lengkap | Tidak boleh kosong | `v.trim().isEmpty ? 'Nama tidak boleh kosong' : null` | 122–123 |
| 2 | Nomor HP | Tidak boleh kosong | `v.trim().isEmpty ? 'Nomor HP tidak boleh kosong' : null` | 137 |
| 3 | Nomor HP | Minimal 9 digit angka | `v.replaceAll(RegExp(r'\D'), '').length < 9` | 138–140 |

```dart
// Validasi 1 — Nama tidak boleh kosong
validator: (v) =>
    (v == null || v.trim().isEmpty) ? 'Nama tidak boleh kosong' : null,

// Validasi 2 & 3 — HP tidak kosong DAN minimal 9 digit
validator: (v) {
  if (v == null || v.trim().isEmpty) return 'Nomor HP tidak boleh kosong';
  if (v.replaceAll(RegExp(r'\D'), '').length < 9) {
    return 'Nomor HP minimal 9 digit';
  }
  return null;
},
```

Validasi dipanggil saat submit:
```dart
if (!_formKey.currentState!.validate()) return;  // L40 — cek semua field sekaligus
```

---

### 5.3 Feedback Pengguna — SnackBar & Dialog

| Situasi | Jenis Feedback | File | Baris |
|---------|---------------|------|-------|
| Tanggal pengerjaan belum dipilih | `SnackBar` merah floating | `order_screen.dart` | 42–47 |
| Tap favorit di DetailScreen | `SnackBar` floating (tambah/hapus) | `detail_screen.dart` | 25–29 |
| Tap FAB / tab Pesanan di NavShell | `SnackBar` floating (petunjuk) | `nav_shell.dart` | 33–38 |
| Form valid + submit sukses | `AlertDialog` ✅ "Pesanan Berhasil!" | `order_screen.dart` | 56–85 |

**SnackBar validasi — order_screen.dart:**
```dart
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  content: Text('⚠️ Pilih tanggal pengerjaan dulu'),
  backgroundColor: Colors.red,
  behavior: SnackBarBehavior.floating,  // muncul mengambang di atas konten
));
```

**AlertDialog sukses — order_screen.dart:**
```dart
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('✅', style: TextStyle(fontSize: 56)),
        Text('Pesanan Berhasil!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        Text('Dana Anda aman di escrow...', textAlign: TextAlign.center),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);  // tutup dialog
          Navigator.pop(context);  // kembali ke detail/home
        },
        child: const Text('Kembali ke Beranda'),
      ),
    ],
  ),
);
```

---

## 6. Struktur File Proyek

```
lib/
├── main.dart                    ← Entry point + ThemeData global + onGenerateRoute
│
├── models/
│   └── service.dart             ← Model ServiceModel + 10 data dummy statis
│
├── screens/
│   ├── home_screen.dart         ← Layar 1: Grid layanan + SliverAppBar
│   ├── detail_screen.dart       ← Layar 2: Detail + favorit (StatefulWidget)
│   ├── order_screen.dart        ← Layar 3: Form pemesanan + validasi
│   └── profile_screen.dart      ← Layar 4: Profil + riwayat pesanan
│
└── widgets/
    ├── nav_shell.dart           ← Shell navigasi: BottomAppBar + FAB + IndexedStack
    └── service_card.dart        ← Card kustom untuk tiap item di grid
```

---

## Ringkasan Pemenuhan Kriteria

| # | Kriteria | Status | Bukti Utama |
|---|----------|--------|-------------|
| 1.1 | Thumb Zone — FAB & Bottom Nav | ✅ | `nav_shell.dart` L30–46 |
| 1.2 | SafeArea & No Layout Overflow | ✅ | `order_screen.dart` L94, `detail_screen.dart` L131 |
| 1.3 | ThemeData Global Konsisten | ✅ | `main.dart` L20–51 |
| 2.1 | Kombinasi Column & Row Kompleks | ✅ | Semua screen, lihat tabel §2.1 |
| 2.2 | Expanded / Flexible (No Overflow) | ✅ | 7 lokasi, lihat tabel §2.2 |
| 2.3 | Stack & Positioned (Elemen Bertumpuk) | ✅ | `nav_shell.dart` L124–141 (badge) |
| 2.4 | Dekorasi Visual (BorderRadius + Shadow) | ✅ | 11 lokasi, lihat tabel §2.4 |
| 3.1 | GridView.builder Dinamis | ✅ | `home_screen.dart` L94–107 |
| 3.2 | Minimal 10 Data Dummy Statis | ✅ | `service.dart` L32–103 (10 item S001–S010) |
| 3.3 | Card Kustom / ListTile per Item | ✅ | `service_card.dart` + 3 ListTile lainnya |
| 4.1 | Minimal 3 Halaman | ✅ | 4 screen (Home, Detail, Order, Profile) |
| 4.2 | Navigator.push / Named Routes | ✅ | `main.dart` L53–66, `service_card.dart` L13 |
| 4.3 | Argument Passing Antar Halaman | ✅ | `ServiceModel` mengalir Home→Detail→Order |
| 4.4 | Navigasi Struktural Permanen | ✅ | `BottomAppBar` 4 tab + `IndexedStack` |
| 5.1 | StatefulWidget + setState() | ✅ | Favorit, loading, ganti tab |
| 5.2 | Form + GlobalKey + 2 Validasi | ✅ | `order_screen.dart` L13, 95, 122–142 |
| 5.3 | Feedback SnackBar | ✅ | 4 SnackBar + 1 AlertDialog sukses |

---

*Dokumentasi ini dibuat berdasarkan kode sumber pada commit terakhir project SobatBeres.*
