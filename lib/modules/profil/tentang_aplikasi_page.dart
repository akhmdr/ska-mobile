import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tentang Aplikasi'),
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tentang Aplikasi', style: AppTheme.textBold16),
              const SizedBox(height: 12),
              const Text(
                'Aplikasi e-SKA Mobile adalah aplikasi resmi dari Kementerian Perdagangan Republik Indonesia yang dirancang untuk memudahkan eksportir dan instansi penerbit SKA (IPSKA) dalam mengakses layanan Surat Keterangan Asal secara digital melalui perangkat mobile.',
                style: AppTheme.textRegular14,
              ),
              const SizedBox(height: 24),

              const Text('Fitur Utama:', style: AppTheme.textBold14),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Login dengan akun OSS dan IPSKA',
                      style: AppTheme.textRegular14,
                    ),
                    Text(
                      '• Pengisian dan pelacakan permohonan SKA',
                      style: AppTheme.textRegular14,
                    ),
                    Text(
                      '• Notifikasi proses layanan',
                      style: AppTheme.textRegular14,
                    ),
                    Text(
                      '• Akses cepat ke pusat informasi dan petunjuk penggunaan',
                      style: AppTheme.textRegular14,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Versi Aplikasi: 1.0.0',
                style: AppTheme.textRegular13,
              ),
              const SizedBox(height: 12),
              const Text(
                'Hak Cipta ©2025 Kementerian Perdagangan Republik Indonesia',
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
