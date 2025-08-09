import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class DetailPenerbitanDABPage extends StatelessWidget {
  const DetailPenerbitanDABPage({super.key});

  // ✅ Dummy bawaan (tidak ada '-' sama sekali)
  static const Map<String, dynamic> _dabDummy = {
    'perusahaan': 'PT SPCIFICA DTR INTERNATIONAL',
    'importir': 'TOKYO IMPORTS LTD',
    'tipeDab': 'DAB Ekspor',
    'noDab': 'DAB-002-2025/07/31',
    'tanggal': '31 Juli 2025 – 10:21 WIB',
    'kantor': 'IPSKA Jakarta',
    'status': 'Diterbitkan',

    'negaraTujuan': 'Jepang',
    'pelabuhanMuat': 'Tanjung Priok',
    'pelabuhanBongkar': 'Tokyo Port',
    'moda': 'Laut',
    'hsCode': '8708.29.90',
    'uraianBarang': 'Automotive Parts – Bracket Assy',

    'fobPeb': '45,634.60 USD',
    'fobInvoice': '45,634.60 USD',
    'fobDokumen': '45,634.60 USD',
    'currency': 'USD',

    'catatan': 'Dokumen lengkap. Siap untuk proses lebih lanjut.',

    'dokumenPendukung': [
      {'judul': 'Dokumen PEB', 'nomor': '000283', 'tanggal': '31 Juli 2025'},
      {'judul': 'Packing List', 'nomor': 'PTY-230-25', 'tanggal': '31 Juli 2025'},
      {'judul': 'Invoice', 'nomor': 'PTY-230-25', 'tanggal': '31 Juli 2025'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    // ✅ Pakai args jika ada; kalau tidak, pakai dummy lengkap (bukan '-')
    final Map<String, dynamic> dab =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ?? _dabDummy;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Detail Penerbitan DAB'),
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header perusahaan + status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          (dab['perusahaan'] ?? _dabDummy['perusahaan']).toString().toUpperCase(),
                          style: AppTheme.textBold14,
                        ),
                      ),
                      _statusBadge((dab['status'] ?? _dabDummy['status']).toString()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _kv('Importir', dab['importir'] ?? _dabDummy['importir']),
                  _kv('Tipe DAB', dab['tipeDab'] ?? dab['tipe'] ?? _dabDummy['tipeDab']),
                  _kv('No. DAB', dab['noDab'] ?? dab['nomorDab'] ?? _dabDummy['noDab']),
                  _kv('Tanggal', dab['tanggal'] ?? _dabDummy['tanggal']),
                  _kv('Kantor', dab['kantor'] ?? _dabDummy['kantor']),
                ],
              ),
            ),

            const SizedBox(height: 16),
            _title('Informasi Pengapalan'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _kv('Negara Tujuan', dab['negaraTujuan'] ?? _dabDummy['negaraTujuan']),
                  _kv('Pelabuhan Muat', dab['pelabuhanMuat'] ?? _dabDummy['pelabuhanMuat']),
                  _kv('Pelabuhan Bongkar', dab['pelabuhanBongkar'] ?? _dabDummy['pelabuhanBongkar']),
                  _kv('Moda Transportasi', dab['moda'] ?? _dabDummy['moda']),
                  _kv('HS Code', dab['hsCode'] ?? _dabDummy['hsCode']),
                  _kv('Uraian Barang', dab['uraianBarang'] ?? _dabDummy['uraianBarang']),
                ],
              ),
            ),

            const SizedBox(height: 16),
            _title('Dokumen Pendukung'),
            const SizedBox(height: 8),
            ..._dokPendukung(context, dab),

            const SizedBox(height: 16),
            _title('Ringkasan Nilai'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _card(bg: Colors.green.shade50, shadow: false),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _kv('FOB (PEB)', dab['fobPeb'] ?? _dabDummy['fobPeb']),
                  _kv('FOB (Invoice)', dab['fobInvoice'] ?? _dabDummy['fobInvoice']),
                  _kv('FOB (Dokumen)', dab['fobDokumen'] ?? _dabDummy['fobDokumen']),
                  _kv('Mata Uang', dab['currency'] ?? _dabDummy['currency']),
                ],
              ),
            ),

            if ((dab['catatan'] ?? _dabDummy['catatan']).toString().isNotEmpty) ...[
              const SizedBox(height: 16),
              _title('Catatan'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: _card(bg: AppTheme.surfaceColor, shadow: false),
                child: Text(
                  (dab['catatan'] ?? _dabDummy['catatan']).toString(),
                  style: AppTheme.textRegular13,
                ),
              ),
            ],

            const SizedBox(height: 24),
            // Tombol aksi bawah
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _snack(context, 'Mengunduh dokumen DAB...'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Unduh DAB'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _snack(context, 'Mengirim verifikasi DAB...'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Verifikasi'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _snack(context, 'Permohonan DAB direvisi.'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Revisi'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ===== helpers =====

  BoxDecoration _card({Color? bg, bool shadow = true}) => BoxDecoration(
        color: bg ?? AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      );

  Widget _title(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t, style: AppTheme.textBold14),
      );

  Widget _kv(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 140, child: Text('$label:', style: AppTheme.textRegular13)),
            Expanded(child: Text(value, style: AppTheme.textBold13)),
          ],
        ),
      );

  Widget _statusBadge(String status) {
    Color bg, fg;
    switch (status.toLowerCase()) {
      case 'sudah':
      case 'diterbitkan':
        bg = Colors.green.shade100; fg = Colors.green.shade800; break;
      case 'proses':
      case 'revisi':
        bg = Colors.orange.shade100; fg = Colors.orange.shade800; break;
      case 'belum':
      case 'ditolak':
        bg = Colors.red.shade100; fg = Colors.red.shade700; break;
      default:
        bg = Colors.grey.shade200; fg = Colors.black87;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(fontSize: 12, color: fg)),
    );
  }

  List<Widget> _dokPendukung(BuildContext context, Map<String, dynamic> dab) {
    final List docs = (dab['dokumenPendukung'] as List?) ?? _dabDummy['dokumenPendukung'];
    return docs.map((d) {
      final j = d['judul']?.toString() ?? '';
      final n = d['nomor']?.toString() ?? '';
      final t = d['tanggal']?.toString() ?? '';
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: _card(),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(j, style: AppTheme.textBold13),
                  const SizedBox(height: 4),
                  Text('Nomor: $n', style: AppTheme.textRegular13),
                  Text('Tanggal: $t', style: AppTheme.textRegular13),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Lihat $j',
              icon: const Icon(Icons.visibility_outlined),
              onPressed: () => _snack(context, 'Melihat $j'),
            ),
            IconButton(
              tooltip: 'Download $j',
              icon: const Icon(Icons.download_outlined),
              onPressed: () => _snack(context, 'Mengunduh $j'),
            ),
          ],
        ),
      );
    }).toList();
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
    );
  }
}