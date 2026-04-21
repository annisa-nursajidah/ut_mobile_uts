import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

class NavShell extends StatefulWidget {
  const NavShell({super.key});

  @override
  State<NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<NavShell> {
  int _index = 0;

  // IndexedStack: screen tidak rebuild saat ganti tab
  // OrderScreen TIDAK dimasukkan di sini — harus dibuka dari DetailScreen
  static const _screens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold sudah otomatis handle SafeArea untuk bottomNavigationBar
    // Jangan bungkus Scaffold dengan SafeArea — itu yang bikin overflow
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),

      // FAB tengah untuk shortcut pesan
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _index = 0);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🛒 Pilih jasa dulu dari Beranda untuk memesan'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        tooltip: 'Pesan Jasa',
        child: const Icon(Icons.add_shopping_cart_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        height: 60, // tinggi eksplisit agar tidak overflow
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            _NavBtn(icon: Icons.home_outlined, label: 'Beranda',
                selected: _index == 0, onTap: () => setState(() => _index = 0)),

            // Notifikasi — badge dengan Stack/Positioned
            _NavBtn(icon: Icons.notifications_none, label: 'Notifikasi',
                selected: false, badgeCount: 3,
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🔔 3 notifikasi baru'),
                      behavior: SnackBarBehavior.floating))),

            const SizedBox(width: 48), // ruang untuk FAB

            _NavBtn(
                icon: Icons.receipt_long_outlined,
                label: 'Pesanan',
                selected: false,
                onTap: () {
                  // Arahkan ke Beranda & beri info
                  setState(() => _index = 0);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🛒 Pilih jasa dulu dari Beranda untuk memesan'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }),

            _NavBtn(icon: Icons.person_outline, label: 'Profil',
                selected: _index == 1, onTap: () => setState(() => _index = 1)),
          ],
        ),
      ),
    );
  }
}

// --- Tab item dengan badge opsional ---
class _NavBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Theme.of(context).colorScheme.primary
        : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4), // dikurangi agar muat di height: 60
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon dengan badge notifikasi
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(icon, color: color),
                  if (badgeCount > 0)
                    Positioned(
                      top: -4, right: -6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                        child: Text('$badgeCount',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 3),
              Text(label,
                  style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
