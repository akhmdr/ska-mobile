import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class PerjanjianPage extends StatelessWidget {
  const PerjanjianPage({super.key});

  final List<Map<String, dynamic>> agreements = const [
    {
      'title': 'INDONESIA MOZAMBIK PTA',
      'subtitle':
          'Rules of Origin Indonesia - Mozambik Preferential Tariff Agreement (M - PTA)',
      'flags': ['🇮🇩', '🇲🇿'],
      'documents': [
        'ROO M PTA',
        'Format Certificate of Origin M-PTA',
        'Operational Certification Procedures M-PTA',
        'Declaration of Origin M-PTA',
      ],
    },
    {
      'title': 'IUAE CEPA',
      'subtitle':
          'Rules of Origin Indonesia UAE Comprehensive Economic Partnership Agreement (IUAE - CEPA)',
      'flags': ['🇮🇩', '🇦🇪'],
      'documents': [
        'ROO IUAE-CEPA',
        'Format Certificate of Origin IUAE-CEPA',
        'Operational Certification Procedures IUAE-CEPA',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Perjanjian Perdagangan'),
      backgroundColor: AppTheme.backgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: agreements.length,
        itemBuilder: (context, index) {
          final agreement = agreements[index];
          return _buildAgreementCard(
            context,
            title: agreement['title'],
            subtitle: agreement['subtitle'],
            flags: agreement['flags'],
            documents: agreement['documents'],
          );
        },
      ),
    );
  }

  Widget _buildAgreementCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<String> flags,
    required List<String> documents,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.textBold14),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTheme.textRegular13),
          const SizedBox(height: 8),
          Row(
            children:
                flags
                    .map((f) => Text(f, style: const TextStyle(fontSize: 20)))
                    .toList(),
          ),
          const Divider(height: 24),
          Text('Document', style: AppTheme.textBold13),
          const SizedBox(height: 12),
          ...documents.map((doc) => _buildDocumentRow(context, doc)).toList(),
        ],
      ),
    );
  }

  Widget _buildDocumentRow(BuildContext context, String docName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.picture_as_pdf_outlined,
            size: 20,
            color: Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(docName, style: AppTheme.textRegular14)),
          TextButton(
            onPressed: () {
              // Snackbar saat klik download
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Mengunduh "$docName"...'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppTheme.primaryColor,
                ),
              );

              // TODO: Ganti dengan logika download asli jika backend sudah ada
            },
            child: const Text(
              'Download',
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }
}
