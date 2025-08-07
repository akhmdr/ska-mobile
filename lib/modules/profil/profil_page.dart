import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profil'),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(),
              const SizedBox(height: 24),

              _buildSectionTitle('Informasi Akun'),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.numbers, 'NIB', '1234567891234'),
              _buildInfoRow(Icons.credit_card, 'NPWP', '123456789012098'),
              _buildInfoRow(
                Icons.account_tree_outlined,
                'Tipe Kantor',
                'Kantor Pusat',
              ),
              _buildInfoRow(Icons.apartment, 'Kantor IPSKA', 'IPSKA DITFAS'),
              _buildInfoRow(Icons.person_outline, 'Username', 'eksportirdemo'),
              _buildInfoRow(
                Icons.email_outlined,
                'Email',
                'demoeksportir@gmail.com',
              ),
              const SizedBox(height: 32),

              _buildSectionTitle('Informasi & Bantuan'),
              const SizedBox(height: 12),
              _buildMenuItem(
                context,
                'Petunjuk Penggunaan',
                Icons.menu_book_outlined,
                '/petunjuk-penggunaan',
              ),
              _buildMenuItem(
                context,
                'Video Tutorial',
                Icons.play_circle_outline,
                '/video-tutorial',
              ),
              _buildMenuItem(
                context,
                'FAQ',
                Icons.question_answer_outlined,
                '/faq',
              ),
              _buildMenuItem(
                context,
                'Perjanjian Dagang',
                Icons.insert_drive_file_outlined,
                '/perjanjian',
              ),
              _buildMenuItem(
                context,
                'Tentang Aplikasi',
                Icons.info_outline,
                '/tentang-aplikasi',
              ),
              _buildMenuItem(
                context,
                'Hubungi Kami',
                Icons.phone_outlined,
                '/kontak-kami',
              ),

              const SizedBox(height: 32),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            child: Icon(Icons.person, size: 32, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DEMO EKSPORTIR', style: AppTheme.textBold16),
              const SizedBox(height: 4),
              Text('Demo Eksportir', style: AppTheme.textRegular14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTheme.textBold16);
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.primaryColor),
          const SizedBox(width: 12),
          Expanded(flex: 3, child: Text(label, style: AppTheme.textRegular14)),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: AppTheme.textBold14,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: AppTheme.textRegular14)),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text(
                    'Apakah Anda yakin ingin keluar dari aplikasi?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
          );
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text('Keluar', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
