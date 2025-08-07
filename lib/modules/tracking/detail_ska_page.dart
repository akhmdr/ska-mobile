// Full code for Detail SKA Page (as discussed)
import 'package:flutter/material.dart';

class DetailSkaPage extends StatelessWidget {
  const DetailSkaPage({super.key});

  void _showConfirmationDialog(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$action Permohonan'),
        content: Text('Anda yakin ingin $action permohonan SKA ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Ya')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail SKA'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Ringkasan Permohonan'),
            _infoBox({
              'No. Aju': 'ID202507310262',
              'Status': 'Kirim ke IPSKA',
              'Nomor SKA': '-',
              'Tanggal Terbit': '-',
              'Kantor IPSKA': 'Prov. Jawa Timur',
            }),

            _sectionTitle('Eksportir'),
            _infoBox({
              'NIB': '9120103795777',
              'NPWP': '0002833464000',
              'Nama Perusahaan': 'PT YAMAMORI INDONESIA',
              'Alamat': 'Jl. Sedati No.1, Sidoarjo',
              'Cek Negara': 'Tidak',
            }),

            _sectionTitle('Penerima Barang'),
            _infoBox({
              'Nama Perusahaan': 'JK Findings',
              'Alamat': '1500 Brighton Henrietta TL Rd, Rochester, NY 14623, USA',
              'Negara': 'UNITED STATES OF AMERICA',
              'Cek Negara': 'Tidak',
              'Keterangan Tambahan': 'Perhitungan Issued Retrospectively dilakukan otomatis oleh Sistem',
            }),

            _sectionTitle('Data Gudang'),
            _infoBox({
              'Alamat Gudang': 'Jl. Sedati No.1',
              'Provinsi': 'JAWA TIMUR',
              'Kota': 'SIDOARJO',
            }),

            _sectionTitle('Rute Transportasi'),
            _infoBox({
              'Jenis': 'BY AIR',
              'Pelabuhan Muat': 'SOEKARNO-HATTA',
              'Pelabuhan Bongkar': 'ROCHESTER, USA',
              'No Dokumen': 'AWB0732025',
              'Tanggal Dokumen': '31 Juli 2025',
              'Jenis Dokumen': 'Dokumen Utama',
            }),

            _sectionTitle('Dokumen Pendukung'),
            _documentTile('Dokumen PEB', '000283', '31 Juli 2025'),
            _documentTile('Packing List', 'PTY-230-25', '31 Juli 2025'),
            _documentTile('Invoice', 'PTY-230-25', '31 Juli 2025'),

            _sectionTitle('Invoice Summary'),
            _infoBox({
              'Total Nilai FOB (PEB)': '45634.60 USD',
              'Total Nilai FOB (Invoice)': '45634.60 USD',
              'Total Nilai FOB (Dokumen)': '45634.60 USD',
            }),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context, 'Verifikasi'),
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
                    onPressed: () => _showConfirmationDialog(context, 'Revisi'),
                    child: const Text('Revisi'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context, 'Tolak'),
                    child: const Text('Tolak'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _infoBox(Map<String, String> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.entries.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text('${e.key}: ${e.value}'),
          );
        }).toList(),
      ),
    );
  }

  Widget _documentTile(String title, String nomor, String tanggal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text('Nomor: $nomor\nTanggal: $tanggal'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.visibility)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.upload_file)),
          ],
        ),
      ),
    );
  }
}