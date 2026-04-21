import 'package:flutter/material.dart';
import '../models/service.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: service),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: emoji di atas background warna
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primary.withAlpha(25),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              alignment: Alignment.center,
              child: Text(service.emoji, style: const TextStyle(fontSize: 40)),
            ),

            // Konten bawah
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori
                    Text(service.category,
                        style: TextStyle(
                            color: primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 3),

                    // Judul
                    Text(service.title,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),

                    const Spacer(),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFBBF24), size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '${service.rating} (${service.reviewCount})',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Harga
                    Text('Rp ${service.formattedPrice}',
                        style: TextStyle(
                            color: primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700)),

                    // Tanda favorit (hanya muncul jika difavoritkan)
                    if (service.isFavorite)
                      const Text('❤️ Favorit',
                          style: TextStyle(fontSize: 11, color: Colors.red)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
