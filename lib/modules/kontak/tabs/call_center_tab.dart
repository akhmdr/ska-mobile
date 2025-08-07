import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';

class CallCenterTab extends StatelessWidget {
  const CallCenterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Helpdesk & Call Center', style: AppTheme.textBold14),
            const SizedBox(height: 4),
            Text('(7 x 24 jam)', style: AppTheme.textRegular13),
            const Divider(height: 24),

            Row(
              children: [
                const Icon(Icons.phone, color: Colors.black54),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('1-500-067', style: AppTheme.textRegular14),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.email_outlined, color: Colors.black54),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'ska@kemendag.go.id',
                    style: AppTheme.textRegular14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              '*Konsultasi hanya menggunakan pesan teks',
              style: AppTheme.textRegular13,
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sms, size: 36, color: Colors.green.shade600),
                const SizedBox(width: 12),
                Text(
                  'Pesan Teks Aktif',
                  style: AppTheme.textBold14.copyWith(
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
