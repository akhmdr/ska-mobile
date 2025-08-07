import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';
import 'package:ska_mobile/modules/tracking/detail_ska_page.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  final List<Map<String, String>> dummyTracking = const [
    {
      'status': 'Diterbitkan',
      'form': 'Form AANZ',
      'eksportir': 'PT Ekspor Sejahtera',
      'nomorAju': 'ID202507310261',
      'nomorSKA': '0038799/JKT/2025',
      'negara': 'Jepang',
      'tanggal': '31 Juli 2025 – 10:21 WIB',
    },
    {
      'status': 'Revisi',
      'form': 'Form AK',
      'eksportir': 'PT Karya Tani',
      'nomorAju': 'ID202507310302',
      'nomorSKA': '0002174/BDG/2025',
      'negara': 'Malaysia',
      'tanggal': '30 Juli 2025 – 09:12 WIB',
    },
    {
      'status': 'Ditolak',
      'form': 'Form E',
      'eksportir': 'PT Gagal Kirim',
      'nomorAju': 'ID202507290111',
      'nomorSKA': '0000020/SMG/2025',
      'negara': 'India',
      'tanggal': '29 Juli 2025 – 08:00 WIB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tracking SKA'),
      backgroundColor: AppTheme.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          ...dummyTracking
              .map((data) => _buildTrackingCard(context, data))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari nomor aju, eksportir...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppTheme.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryColor),
        ),
      ),
    );
  }

  Widget _buildTrackingCard(BuildContext context, Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row status + form
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge(data['status']!),
              Text(data['form']!, style: AppTheme.textBold13),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfo('Eksportir', data['eksportir']!),
          _buildInfo('Nomor Aju', data['nomorAju']!),
          _buildInfo('Nomor SKA', data['nomorSKA']!),
          _buildInfo('Negara Tujuan', data['negara']!),
          _buildInfo('Tanggal Permohonan', data['tanggal']!),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildActionButton(
                label: 'Lihat',
                color: Colors.green.shade100,
                onTap: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailSkaPage()),
                      );;
                },
              ),
              const SizedBox(width: 12),
              if (data['status'] == 'Diterbitkan')
                _buildActionButton(
                  label: 'Download',
                  color: Colors.green.shade50,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mengunduh dokumen SKA...')),
                    );
                  },
                ),
              if (data['status'] == 'Revisi')
                _buildActionButton(
                  label: 'Verifikasi',
                  color: Colors.orange.shade100,
                  onTap: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Diterbitkan':
        bgColor = Colors.green.shade100;
        textColor = Colors.green;
        break;
      case 'Revisi':
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'Ditolak':
        bgColor = Colors.red.shade100;
        textColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey.shade300;
        textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status, style: TextStyle(fontSize: 12, color: textColor)),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$label: ', style: AppTheme.textBold13),
            TextSpan(text: value, style: AppTheme.textRegular13),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label, style: AppTheme.textBold13),
        ),
      ),
    );
  }
}
