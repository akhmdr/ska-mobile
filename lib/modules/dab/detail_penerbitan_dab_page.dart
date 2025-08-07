import 'package:flutter/material.dart';

class DetailPenerbitanDABPage extends StatelessWidget {
  const DetailPenerbitanDABPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Penerbitan DAB')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Ringkasan Permohonan'),
          _infoRow('Nama Perusahaan', 'MUHAMMAD ARIF PRATAMA'),
          _infoRow('NIB', '0402202280105'),
          _infoRow('NPWP', '194375484454000'),
          _infoRow('Alamat', 'KP BATULAWANG RT.001 RW.028, BANDUNG'),
          _infoRow('Penanggung Jawab', 'MUHAMMAD ARIF PRATAMA'),
          const Divider(),

          _sectionTitle('Penerima Barang'),
          _infoRow('Nama Perusahaan', 'PT XYZ'),
          _infoRow('Alamat', 'STREET 1'),
          _infoRow('Negara', 'AUSTRALIA'),
          const Divider(),

          _sectionTitle('Rute Transportasi'),
          _infoRow('Jenis Transportasi', 'by SEA'),
          _infoRow('Nama Transportasi', 'EVERGREEN'),
          _infoRow('Pelabuhan Muat', 'Tanjung Priok'),
          _infoRow('Pelabuhan Bongkar', 'Sydney'),
          _infoRow('Nomor Dokumen', '1244'),
          _infoRow('Tanggal Dokumen', '24 April 2025'),
          const Divider(),

          _sectionTitle('Dokumen Pendukung'),
          _infoRow('Dokumen PEB', 'No. 1234 - 24 April 2025'),
          _infoRow('Daftar Kemasan', 'No. 12345 - 24 April 2025'),
          _infoRow('NPE', 'No. 1234 - 24 April 2025'),
          _infoRow('KPPBC', '040300 - KPU BC TIPE A TANJUNG PRIOK'),
          const Divider(),

          _sectionTitle('Invoice'),
          _infoRow('Nomor Invoice', '123456789'),
          _infoRow('Tanggal Invoice', '24 April 2025'),
          _infoRow('Nilai Invoice', '5,000,000 USD'),
          const SizedBox(height: 12),
          _infoRow('Total Nilai FOB pada Goods', '5,000,000 USD'),
          _infoRow('Total Nilai FOB pada Invoice', '5,000,000 USD'),
          _infoRow('Nilai FOB pada PEB', '5,000,000 USD'),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  );

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: Text("$label:")),
        Expanded(flex: 6, child: Text(value)),
      ],
    ),
  );
}