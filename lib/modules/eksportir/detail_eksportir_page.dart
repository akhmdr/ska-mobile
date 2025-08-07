

import 'package:flutter/material.dart';

class DetailEksportirPage extends StatelessWidget {
  final String perusahaan, nib, npwp, alamat, kantor, status;

  const DetailEksportirPage({
    super.key,
    required this.perusahaan,
    required this.nib,
    required this.npwp,
    required this.alamat,
    required this.kantor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Eksportir")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("Informasi Perusahaan"),
          _infoRow("Nama Perusahaan", perusahaan),
          _infoRow("NIB", nib),
          _infoRow("NPWP", npwp),
          _infoRow("Alamat", alamat),
          _infoRow("Status", status),
          _infoRow("Kantor IPSKA", kantor),
          _infoRow("Tipe Kantor", "Kantor Pusat"),
          const Divider(height: 32),

          _sectionTitle("Pabrik / Gudang"),
          _infoRow("Alamat Pabrik", "jalan panjang arah tower"),
          _infoRow("Provinsi", "DKI JAKARTA"),
          _infoRow("Kota / Kabupaten", "KOTA ADM. JAKARTA BARAT"),
          const Divider(height: 32),

          _sectionTitle("Penanggung Jawab"),
          _infoRow("Nama", "MUHAMMAD ARIF PRATAMA"),
          _infoRow("Jabatan", "Pemilik"),
          _infoRow("No. Telepon", "08999999998"),
          _infoRow("Email", "vitestesting@gmail.com"),
          const Divider(height: 32),

          _sectionTitle("Skema ER-ES"),
          _infoRow("No. Permohonan", "0000089/SKEMA/2025"),
          _infoRow("IDRCEP", "IDR0402202280105"),
          _infoRow("Tanggal", "06 Februari 2025"),
          _infoRow("Status", "Registrasi RCEP Berhasil"),
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