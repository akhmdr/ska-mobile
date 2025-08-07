import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class PetunjukPenggunaanPage extends StatelessWidget {
  const PetunjukPenggunaanPage({super.key});

  final List<Map<String, String>> guides = const [
    {'title': 'Panduan Pengisian Cost Structure', 'desc': ''},
    {
      'title': 'Dokumen Panduan Upload SKA',
      'desc': 'STRUKTUR DATA DETAIL GOODS DAN COST STRUCTURE E-SKA',
    },
    {
      'title': 'Format Upload Excel untuk Pengajuan form SKA',
      'desc': 'File Excel yang digunakan untuk Upload data pengajuan form SKA',
    },
    {
      'title': 'Petunjuk Penggunaan eSKA v2 - Pengajuan Form SKA',
      'desc': 'Petunjuk Penggunaan eSKA v2 – Pengajuan Form SKA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Petunjuk Penggunaan'),
      backgroundColor: AppTheme.backgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: guides.length,
        itemBuilder: (context, index) {
          final guide = guides[index];
          return _buildGuideCard(
            context,
            title: guide['title']!,
            description: guide['desc']!,
          );
        },
      ),
    );
  }

  Widget _buildGuideCard(
    BuildContext context, {
    required String title,
    required String description,
  }) {
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
          Row(
            children: const [
              Icon(Icons.menu_book, color: Colors.orange, size: 28),
              SizedBox(width: 12),
              Expanded(child: Text('Panduan', style: AppTheme.textBold14)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: AppTheme.textBold14),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(description, style: AppTheme.textRegular13),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mengunduh "$title"...'),
                    backgroundColor: AppTheme.primaryColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('DOWNLOAD'),
            ),
          ),
        ],
      ),
    );
  }
}
