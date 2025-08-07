import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  final List<Map<String, dynamic>> faqData = const [
    {
      'category': 'Tentang Akun SKA',
      'questions': [
        {
          'question': 'Apakah eksportir menggunakan akun OSS atau eSKA V1?',
          'answer':
              'Eksportir menggunakan akun OSS untuk login ke sistem eSKA terbaru.',
        },
        {
          'question': 'Bagaimana cara registrasi akun SKA v2?',
          'answer':
              'Registrasi dilakukan dengan akun OSS RBA, lalu login melalui SSO.',
        },
      ],
    },
    {
      'category': 'Penggunaan Sistem',
      'questions': [
        {
          'question': 'Apakah bisa mengganti email yang terdaftar?',
          'answer':
              'Email akun hanya bisa diubah melalui update profil melalui sistem OSS.',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'FAQ'),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: faqData.length,
          itemBuilder: (context, index) {
            final category = faqData[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category['category'], style: AppTheme.textBold14),
                const SizedBox(height: 12),
                ...List.generate(
                  category['questions'].length,
                  (qIndex) => _buildFaqTile(
                    category['questions'][qIndex]['question'],
                    category['questions'][qIndex]['answer'],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFaqTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          title: Text(question, style: AppTheme.textRegular14),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(answer, style: AppTheme.textRegular14),
            ),
          ],
        ),
      ),
    );
  }
}
