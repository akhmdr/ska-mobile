import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class DetailEksportirPage extends StatelessWidget {
  final String perusahaan;
  final String nib;
  final String npwp;
  final String alamat;
  final String kantor;
  final String status;

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
      appBar: const CustomAppBar(title: 'Detail Eksportir'),
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Informasi Perusahaan'),
            _buildItem('Nama Perusahaan', perusahaan),
            _buildItem('NIB', nib),
            _buildItem('NPWP', npwp),
            _buildItem('Alamat', alamat),
            _buildItem('Status', status),
            _buildItem('Kantor IPSKA', kantor),
            _buildItem('Tipe Kantor', 'Kantor Pusat'),
            const Divider(height: 32),

            _buildSectionTitle('Pabrik / Gudang'),
            _buildItem('Alamat Pabrik', 'jalan panjang arah tower'),
            _buildItem('Provinsi', 'DKI JAKARTA'),
            _buildItem('Kota / Kabupaten', 'KOTA ADM. JAKARTA BARAT'),
            const Divider(height: 32),

            _buildSectionTitle('Penanggung Jawab'),
            _buildItem('Nama', 'MUHAMMAD ARIF PRATAMA'),
            _buildItem('Jabatan', 'Pemilik'),
            _buildItem('No. Telepon', '089999999998'),
            _buildItem('Email', 'vitestesting@gmail.com'),
            const Divider(height: 32),

            _buildSectionTitle('Skema ER-ES'),
            _buildItem('No. Permohonan', '0000089/SKEMA/2025'),
            _buildItem('IDRCEP', 'IDR0402202280105'),
            _buildItem('Tanggal', '06 Februari 2025'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: AppTheme.textBold14),
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text('$label:', style: AppTheme.textRegular13),
          ),
          Expanded(child: Text(value, style: AppTheme.textBold13)),
        ],
      ),
    );
  }
}
