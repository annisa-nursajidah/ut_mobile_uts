import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Data dummy riwayat pesanan
  static const _orders = [
    {'title': 'Bersih-Bersih Rumah', 'date': '12 Apr 2025', 'status': 'Selesai', 'done': true},
    {'title': 'Servis AC Split', 'date': '05 Apr 2025', 'status': 'Dana Ditahan', 'done': false},
    {'title': 'Les Privat Matematika', 'date': '28 Mar 2025', 'status': 'Selesai', 'done': true},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- Header profil ---
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            title: const Text('Profil Saya'),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white24,
                      child: Text('👤', style: TextStyle(fontSize: 40)),
                    ),
                    const SizedBox(height: 10),
                    const Text('Ahmad Fauzi',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    const Text('ahmad.fauzi@email.com',
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // --- Status Escrow ---
                Text('Status Escrow', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _EscrowStat(label: 'Aktif', value: '2',
                        icon: Icons.hourglass_top, color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    _EscrowStat(label: 'Selesai', value: '8',
                        icon: Icons.check_circle_outline, color: theme.colorScheme.secondary),
                    const SizedBox(width: 10),
                    _EscrowStat(label: 'Dana Aman', value: '450rb',
                        icon: Icons.account_balance_wallet_outlined,
                        color: Colors.orange),
                  ],
                ),

                const SizedBox(height: 24),

                // --- Riwayat Pesanan ---
                Text('Riwayat Pesanan', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                ..._orders.map((o) => _OrderCard(order: o)),

                const SizedBox(height: 24),

                // --- Menu pengaturan ---
                Text('Pengaturan', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                Card(
                  child: Column(
                    children: [
                      _MenuItem(icon: Icons.person_outline, label: 'Edit Profil'),
                      const Divider(height: 1, indent: 56),
                      _MenuItem(icon: Icons.notifications_none, label: 'Notifikasi'),
                      const Divider(height: 1, indent: 56),
                      _MenuItem(icon: Icons.security, label: 'Keamanan Akun'),
                      const Divider(height: 1, indent: 56),
                      _MenuItem(icon: Icons.help_outline, label: 'Bantuan & FAQ'),
                      const Divider(height: 1, indent: 56),
                      _MenuItem(
                          icon: Icons.logout,
                          label: 'Keluar',
                          color: Colors.red),
                    ],
                  ),
                ),

                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Widget kecil: stat escrow ---
class _EscrowStat extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;

  const _EscrowStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                    color: color, fontSize: 16, fontWeight: FontWeight.w700)),
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

// --- Widget kecil: kartu riwayat pesanan ---
class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final isDone = order['done'] as bool;
    final statusColor = isDone ? Colors.green : Theme.of(context).colorScheme.primary;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(order['title']!),
        subtitle: Text(order['date']!),
        trailing: Chip(
          label: Text(order['status']!,
              style: TextStyle(color: statusColor, fontSize: 11)),
          backgroundColor: statusColor.withAlpha(25),
        ),
      ),
    );
  }
}

// --- Widget kecil: item menu ---
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  const _MenuItem({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.grey.shade600),
      title: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
