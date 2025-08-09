import 'package:flutter/material.dart';
import 'package:ska_mobile/modules/kontak/kontak_kami_page.dart';
import 'package:ska_mobile/modules/profil/faq_page.dart';
import 'package:ska_mobile/modules/profil/manajemen_perusahaan_page.dart';
import 'package:ska_mobile/modules/profil/perjanjian_page.dart';
import 'package:ska_mobile/modules/profil/petunjuk_penggunaan_page.dart';
import 'package:ska_mobile/modules/profil/profil_perusahaan_page.dart';
import 'package:ska_mobile/modules/profil/tentang_aplikasi_page.dart';
import 'package:ska_mobile/modules/profil/video_tutorial_page.dart';
import 'modules/login/login_page.dart';

void main() {
  runApp(const MyApp());
  // Tambahkan rute lainnya di sini jika diperlukan
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SKA Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/faq': (context) => const FaqPage(),
        '/petunjuk-penggunaan': (context) => const PetunjukPenggunaanPage(),
        '/video-tutorial': (context) => const VideoTutorialPage(),
        '/kontak-kami': (context) => const KontakKamiPage(),
        '/perjanjian': (context) => const PerjanjianPage(),
        '/tentang-aplikasi': (context) => const TentangAplikasiPage(),
        '/profil-perusahaan': (context) => const ProfilPerusahaanPage(),
        '/manajemen-perusahaan': (context) => const ManajemenPerusahaanPage(),
          // Ganti dengan halaman detail eksp
      },
      // Tambahkan rute lainnya di sini jika diperlukan
    );
  }
}


