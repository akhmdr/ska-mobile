import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class DetailSKAPage extends StatelessWidget {
  const DetailSKAPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari arguments (kirim dari TrackingPage)
    // Pastikan saat pushNamed kamu mengirim Map<String, String> atau model yang di-map
    final Map<String, dynamic> data =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ?? {};

    return Scaffold(
      appBar: const CustomAppBar(title: 'Detail SKA'),
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== Header Ringkas (info utama permohonan) ======
            _sectionCard(
              children: [
                _kv('Eksportir', data['eksportir'] ?? '-'),
                _kv('Nomor Aju', data['nomorAju'] ?? '-'),
                _kv('Nomor SKA', data['nomorSKA'] ?? '-'),
                _kv('Negara Tujuan', data['negara'] ?? '-'),
                _kv('Tanggal Permohonan', data['tanggal'] ?? '-'),
                if (data['form'] != null) _kv('Form', data['form']),
                if (data['status'] != null) _kv('Status', data['status']),
              ],
            ),
            const SizedBox(height: 16),

            // ====== Detail Dokumen Utama / PEB (Jangan hilangkan data) ======
            _title('Detail Dokumen'),
            _sectionCard(
              children: [
                _kv('Pelabuhan Muat', data['pelabuhanMuat'] ?? 'SOEKARNO-HATTA'),
                _kv('Pelabuhan Bongkar', data['pelabuhanBongkar'] ?? 'ROCHESTER, USA'),
                _kv('No Dokumen', data['noDokumen'] ?? 'AWB0732025'),
                _kv('Tanggal Dokumen', data['tglDokumen'] ?? '31 Juli 2025'),
                _kv('Jenis Dokumen', data['jenisDokumen'] ?? 'Dokumen Utama'),
              ],
            ),
            const SizedBox(height: 24),

            // ====== Dokumen Pendukung (Jangan hilangkan data di kartu) ======
            _title('Dokumen Pendukung'),
            const SizedBox(height: 8),
            _docCard(
              context,
              judul: 'Dokumen PEB',
              nomor: data['pebNomor'] ?? '000283',
              tanggal: data['pebTanggal'] ?? '31 Juli 2025',
              onView: () => _snack(context, 'Melihat Dokumen PEB'),
              onDownload: () => _snack(context, 'Mengunduh Dokumen PEB'),
            ),
            _docCard(
              context,
              judul: 'Packing List',
              nomor: data['plNomor'] ?? 'PTY-230-25',
              tanggal: data['plTanggal'] ?? '31 Juli 2025',
              onView: () => _snack(context, 'Melihat Packing List'),
              onDownload: () => _snack(context, 'Mengunduh Packing List'),
            ),
            _docCard(
              context,
              judul: 'Invoice',
              nomor: data['invNomor'] ?? 'PTY-230-25',
              tanggal: data['invTanggal'] ?? '31 Juli 2025',
              onView: () => _snack(context, 'Melihat Invoice'),
              onDownload: () => _snack(context, 'Mengunduh Invoice'),
            ),
            const SizedBox(height: 24),

            // ====== Invoice Summary (semua angka tetap ditampilkan) ======
            _title('Invoice Summary'),
            _sectionCard(
              bg: Colors.green.shade50,
              children: [
                _kv('Total Nilai FOB (PEB)', data['fobPeb'] ?? '45634.60 USD'),
                _kv('Total Nilai FOB (Invoice)', data['fobInv'] ?? '45634.60 USD'),
                _kv('Total Nilai FOB (Dokumen)', data['fobDok'] ?? '45634.60 USD'),
              ],
            ),

            const SizedBox(height: 24),

            // ====== Tombol aksi bawah (style konsisten) ======
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _snack(context, 'Verifikasi berhasil diajukan'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Verifikasi'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _snack(context, 'Permohonan dikembalikan untuk revisi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Revisi'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _snack(context, 'Permohonan ditolak'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Tolak'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ---------- Helpers UI ----------

  Widget _title(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: AppTheme.textBold14),
      );

  Widget _sectionCard({required List<Widget> children, Color? bg}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg ?? AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (bg == null)
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _kv(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 160, child: Text('$label:', style: AppTheme.textRegular13)),
          Expanded(child: Text(value, style: AppTheme.textBold13)),
        ],
      ),
    );
  }

  Widget _docCard(
    BuildContext context, {
    required String judul,
    required String nomor,
    required String tanggal,
    required VoidCallback onView,
    required VoidCallback onDownload,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Info lengkap (JANGAN DIHAPUS)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(judul, style: AppTheme.textBold13),
                const SizedBox(height: 4),
                Text('Nomor: $nomor', style: AppTheme.textRegular13),
                Text('Tanggal: $tanggal', style: AppTheme.textRegular13),
              ],
            ),
          ),
          // Aksi: lihat & download (dengan snackbar)
          IconButton(
            tooltip: 'Lihat $judul',
            icon: const Icon(Icons.visibility_outlined),
            onPressed: onView,
          ),
          IconButton(
            tooltip: 'Download $judul',
            icon: const Icon(Icons.download_outlined),
            onPressed: onDownload,
          ),
        ],
      ),
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
    );
  }
}