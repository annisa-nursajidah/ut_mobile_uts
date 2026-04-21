class ServiceModel {
  final String id;
  final String title;
  final String category;
  final String providerName;
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  final String emoji;
  bool isFavorite;

  ServiceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.providerName,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.emoji,
    this.isFavorite = false,
  });

  // Format harga jadi "150.000"
  String get formattedPrice => price
      .toInt()
      .toString()
      .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');

  static final List<ServiceModel> dummyData = [
    ServiceModel(
      id: 'S001', emoji: '🧹', category: 'Kebersihan',
      title: 'Bersih-Bersih Rumah',
      providerName: 'Budi Santoso',
      price: 150000, rating: 4.8, reviewCount: 132,
      description: 'Layanan kebersihan rumah profesional: sapu, pel, kamar mandi, dapur. Peralatan disediakan. Garansi kepuasan via escrow.',
    ),
    ServiceModel(
      id: 'S002', emoji: '❄️', category: 'Elektronik',
      title: 'Servis AC Split & Cuci',
      providerName: 'Teknik Jaya',
      price: 200000, rating: 4.9, reviewCount: 87,
      description: 'Servis dan cuci AC berbagai merk. Freon isi ulang tersedia (biaya terpisah). Teknisi 10 tahun pengalaman.',
    ),
    ServiceModel(
      id: 'S003', emoji: '📐', category: 'Pendidikan',
      title: 'Les Privat Matematika',
      providerName: 'Dewi Rahayu',
      price: 100000, rating: 4.7, reviewCount: 214,
      description: 'Guru matematika SD–SMP. Metode menyenangkan, sabar, terbukti meningkatkan nilai. Per sesi 90 menit.',
    ),
    ServiceModel(
      id: 'S004', emoji: '🎨', category: 'Desain',
      title: 'Desain Logo & Branding',
      providerName: 'Rina Creative',
      price: 350000, rating: 4.6, reviewCount: 59,
      description: '3 konsep logo, revisi unlimited, format AI/PNG/PDF. Selesai 3 hari kerja.',
    ),
    ServiceModel(
      id: 'S005', emoji: '💆', category: 'Kesehatan',
      title: 'Pijat Panggilan Terapis',
      providerName: 'Wellness.id',
      price: 180000, rating: 4.5, reviewCount: 176,
      description: 'Terapis bersertifikat datang ke lokasi Anda. Durasi 60–90 menit, peralatan lengkap.',
    ),
    ServiceModel(
      id: 'S006', emoji: '🚗', category: 'Otomotif',
      title: 'Cuci Motor & Mobil',
      providerName: 'AutoCare Express',
      price: 50000, rating: 4.4, reviewCount: 301,
      description: 'Cuci kendaraan di tempat Anda. Motor Rp50.000 | Mobil Rp80.000. Sabun premium, lap microfiber.',
    ),
    ServiceModel(
      id: 'S007', emoji: '⚡', category: 'Teknik',
      title: 'Instalasi & Servis Listrik',
      providerName: 'Pak Surya Listrik',
      price: 120000, rating: 4.8, reviewCount: 98,
      description: 'Instalasi stop kontak, saklar, lampu, MCB. Bergaransi 30 hari. PLN terdaftar.',
    ),
    ServiceModel(
      id: 'S008', emoji: '📸', category: 'Fotografi',
      title: 'Foto Produk UMKM',
      providerName: 'LensaKu Studio',
      price: 250000, rating: 4.7, reviewCount: 43,
      description: '10 objek, editing, siap upload. Background putih/custom. File dikirim via Google Drive.',
    ),
    ServiceModel(
      id: 'S009', emoji: '🛵', category: 'Logistik',
      title: 'Antar Barang Dalam Kota',
      providerName: 'KirimiAja',
      price: 25000, rating: 4.3, reviewCount: 520,
      description: 'Maks 5 kg, radius 20 km. Estimasi 1–2 jam. Bukti foto penerima dikirim otomatis.',
    ),
    ServiceModel(
      id: 'S010', emoji: '💻', category: 'IT & Digital',
      title: 'Pembuatan Website Bisnis',
      providerName: 'CodeCraft Dev',
      price: 1500000, rating: 4.9, reviewCount: 31,
      description: 'Website company profile responsif, SEO-friendly, CMS mudah. Domain .com + hosting 1 tahun.',
    ),
  ];
}
