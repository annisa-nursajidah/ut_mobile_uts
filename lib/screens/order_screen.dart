import 'package:flutter/material.dart';
import '../models/service.dart';

class OrderScreen extends StatefulWidget {
  final ServiceModel? service;
  const OrderScreen({super.key, this.service});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  DateTime? _date;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _submit() async {
    // Validasi form + tanggal
    if (!_formKey.currentState!.validate()) return;
    if (_date == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('⚠️ Pilih tanggal pengerjaan dulu'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // simulasi loading
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Tampilkan hasil sukses
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('✅', style: TextStyle(fontSize: 56)),
            SizedBox(height: 12),
            Text('Pesanan Berhasil!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text(
              'Dana Anda aman di escrow dan akan cair setelah pekerjaan selesai.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // tutup dialog
              Navigator.pop(context); // kembali
            },
            child: const Text('Kembali ke Beranda'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.service;

    return Scaffold(
      appBar: AppBar(title: const Text('Form Pemesanan')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Ringkasan jasa yang dipesan
              if (s != null) ...[
                Card(
                  child: ListTile(
                    leading: Text(s.emoji, style: const TextStyle(fontSize: 32)),
                    title: Text(s.title),
                    subtitle: Text(s.providerName),
                    trailing: Text('Rp ${s.formattedPrice}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // --- Validasi 1: Nama tidak boleh kosong ---
              TextFormField(
                controller: _nameCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 14),

              // --- Validasi 2: Nomor HP minimal 9 digit ---
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP (WhatsApp)',
                  prefixIcon: Icon(Icons.phone_outlined),
                  prefixText: '+62 ',
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Nomor HP tidak boleh kosong';
                  if (v.replaceAll(RegExp(r'\D'), '').length < 9) {
                    return 'Nomor HP minimal 9 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Tanggal pengerjaan (tap untuk picker)
              GestureDetector(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Pengerjaan',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  child: Text(
                    _date == null
                        ? 'Pilih tanggal...'
                        : '${_date!.day}/${_date!.month}/${_date!.year}',
                    style: TextStyle(
                      color: _date == null ? Colors.grey : Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _noteCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan (opsional)',
                  prefixIcon: Icon(Icons.notes_outlined),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),

              // Info escrow
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withAlpha(80)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Pembayaran ditahan di escrow. Dana cair ke penyedia setelah Anda konfirmasi selesai.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF92400E)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Konfirmasi & Bayar via Escrow'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
