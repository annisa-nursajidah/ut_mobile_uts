import 'package:flutter/material.dart';
import '../models/service.dart';
import '../widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildSearchBar(),
          _buildSectionHeader(context),
          _buildGrid(),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 130,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Selamat Datang 👋',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              SizedBox(height: 4),
              Text('Cari Jasa Terbaik di Sekitar Anda',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari jasa...',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding _buildSectionHeader(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Semua Layanan',
                style: Theme.of(context).textTheme.titleLarge),
            Text('${ServiceModel.dummyData.length} jasa',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 13)),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildGrid() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemCount: ServiceModel.dummyData.length,
        itemBuilder: (_, i) => ServiceCard(service: ServiceModel.dummyData[i]),
      ),
    );
  }
}
