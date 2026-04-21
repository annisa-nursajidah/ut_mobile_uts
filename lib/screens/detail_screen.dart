import 'package:flutter/material.dart';
import '../models/service.dart';

class DetailScreen extends StatefulWidget {
  final ServiceModel service;
  const DetailScreen({super.key, required this.service});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.service.isFavorite;
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    widget.service.isFavorite = _isFavorite;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_isFavorite ? '❤️ Ditambahkan ke favorit' : 'Dihapus dari favorit'),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.service;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- App Bar dengan emoji besar ---
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red.shade300 : Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: theme.colorScheme.primary,
                alignment: Alignment.center,
                child: Text(s.emoji, style: const TextStyle(fontSize: 80)),
              ),
            ),
          ),

          // --- Konten ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori
                  Chip(
                    label: Text(s.category),
                    backgroundColor: theme.colorScheme.primary.withAlpha(25),
                    labelStyle: TextStyle(
                        color: theme.colorScheme.primary, fontSize: 12),
                  ),

                  const SizedBox(height: 8),
                  Text(s.title, style: theme.textTheme.headlineMedium),

                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFBBF24), size: 18),
                      const SizedBox(width: 4),
                      Text('${s.rating}  •  ${s.reviewCount} ulasan',
                          style: theme.textTheme.bodyMedium),
                    ],
                  ),

                  const SizedBox(height: 16),
                  // Penyedia jasa
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor:
                          theme.colorScheme.primary.withAlpha(25),
                      child: const Text('👤'),
                    ),
                    title: Text(s.providerName,
                        style: theme.textTheme.titleLarge),
                    subtitle: Text('Penyedia Terverifikasi ✓',
                        style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontSize: 12)),
                    trailing:
                        Icon(Icons.verified, color: theme.colorScheme.secondary),
                  ),

                  const Divider(height: 28),
                  Text('Deskripsi', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(s.description,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(height: 1.6)),

                  const SizedBox(height: 20),
                  // Banner escrow
                  _EscrowBanner(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // --- Bottom bar: harga + tombol pesan ---
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Harga mulai',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(
                    'Rp ${s.formattedPrice}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/order', arguments: s),
                  child: const Text('Pesan Sekarang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget kecil untuk banner escrow — dipisah agar build() tidak terlalu panjang
class _EscrowBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10B981).withAlpha(80)),
      ),
      child: const Row(
        children: [
          Icon(Icons.shield_outlined, color: Color(0xFF10B981)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Dana aman via Escrow SobatBeres. Cair hanya setelah pekerjaan selesai.',
              style: TextStyle(color: Color(0xFF065F46), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
