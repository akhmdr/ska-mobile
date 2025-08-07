import 'package:flutter/material.dart';
import 'package:ska_mobile/modules/tracking/detail_ska_page.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final skaList = [
      {
        'status': 'Diterbitkan',
        'form': 'Form AANZ',
        'nomorAju': 'ID202507310261',
        'nomorSKA': '0038799/JKT/2025',
        'eksportir': 'PT Ekspor Sejahtera',
        'negara': 'Jepang',
        'tanggal': '31 Juli 2025 - 10:21 WIB',
      },
      {
        'status': 'Revisi',
        'form': 'Form AK',
        'nomorAju': 'ID202507310302',
        'nomorSKA': '0002174/BDG/2025',
        'eksportir': 'PT Karya Tani',
        'negara': 'Malaysia',
        'tanggal': '30 Juli 2025 - 09:12 WIB',
      },
      {
        'status': 'Ditolak',
        'form': 'Form E',
        'nomorAju': 'ID202507280119',
        'nomorSKA': '0001023/SBY/2025',
        'eksportir': 'PT Agro Nusantara',
        'negara': 'Thailand',
        'tanggal': '28 Juli 2025 - 13:45 WIB',
      },
      {
        'status': 'Diproses',
        'form': 'Form IJEPA',
        'nomorAju': 'ID202507290456',
        'nomorSKA': '0009871/MKS/2025',
        'eksportir': 'CV Berkat Laut',
        'negara': 'Korea Selatan',
        'tanggal': '29 Juli 2025 - 08:30 WIB',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking SKA'),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari nomor aju, eksportir...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: skaList.length,
              itemBuilder: (context, index) {
                final item = skaList[index];
                return _SkaCard(data: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SkaCard extends StatelessWidget {
  final Map<String, String> data;

  const _SkaCard({required this.data});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diterbitkan':
        return Colors.green;
      case 'Ditolak':
        return Colors.red;
      case 'Revisi':
        return Colors.orange;
      case 'Diproses':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  List<String> _getActionForStatus(String status) {
    switch (status) {
      case 'Diterbitkan':
        return ['Lihat', 'Download'];
      case 'Revisi':
        return ['Lihat', 'Verifikasi'];
      case 'Ditolak':
        return ['Lihat'];
      case 'Diproses':
        return ['Lihat', 'Verifikasi'];
      default:
        return ['Lihat'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final actions = _getActionForStatus(data['status']!);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: status + form
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(data['status']!),
                  backgroundColor: _getStatusColor(data['status']!).withOpacity(0.2),
                  labelStyle: TextStyle(color: _getStatusColor(data['status']!)),
                ),
                Text(data['form']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Eksportir: ${data['eksportir']}'),
            Text('Nomor Aju: ${data['nomorAju']}'),
            Text('Nomor SKA: ${data['nomorSKA']}'),
            Text('Negara Tujuan: ${data['negara']}'),
            Text('Tanggal Permohonan: ${data['tanggal']}'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: actions.map((label) {
                return ElevatedButton(
                  onPressed: () {
                    if (label == 'Lihat') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailSkaPage()),
                      );
                    } else if (label == 'Verifikasi') {
                      // Handle verification logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verifikasi untuk ${data['nomorAju']}')),
                      );
                    } else if (label == 'Download') {
                      // Handle download logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Download SKA ${data['nomorSKA']}')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black87,
                    elevation: 0,
                  ),
                  child: Text(label),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}