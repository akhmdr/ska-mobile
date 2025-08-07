// lib/data/services/beranda_service.dart
import 'package:flutter/material.dart';
import '../../core/models/models.dart';

class BerandaService {
  static BerandaService? _instance;
  BerandaService._internal();
  
  static BerandaService get instance {
    _instance ??= BerandaService._internal();
    return _instance!;
  }

  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<List<BannerItem>> getBanners() async {
    await _simulateDelay();
    
    return [
      BannerItem(
        id: '1',
        title: 'Banner Promo SKA',
        imagePath: 'assets/images/banners/banner01.jpeg',
        url: 'https://ska.kemendag.go.id/promo',
      ),
      BannerItem(
        id: '2',
        title: 'Layanan Ekspor Terbaru',
        imagePath: 'assets/images/banners/banner02.jpeg',
        url: 'https://ska.kemendag.go.id/layanan',
      ),
      BannerItem(
        id: '3',
        title: 'Panduan Ekspor 2025',
        imagePath: 'assets/images/banners/banner03.png',
        url: 'https://ska.kemendag.go.id/panduan',
      ),
    ];
  }

  Future<List<QuickAccessItem>> getQuickAccess() async {
    await _simulateDelay();
    
    return [
      QuickAccessItem(
        title: 'Video Tutorial',
        subtitle: 'Panduan sistem SKA',
        icon: Icons.play_circle_fill,
        color: Colors.red,
      ),
      QuickAccessItem(
        title: 'Call Center',
        subtitle: 'Hubungi tim SKA',
        icon: Icons.call,
        color: Colors.green,
      ),
      QuickAccessItem(
        title: 'Tarif Preferensi',
        subtitle: 'Lihat daftar tarif',
        icon: Icons.local_shipping,
        color: Colors.blue,
      ),
      QuickAccessItem(
        title: 'Data Eksportir',
        subtitle: 'Daftar eksportir terdaftar',
        icon: Icons.factory,
        color: Colors.orange,
      ),
      QuickAccessItem(
        title: 'Tracking SKA',
        subtitle: 'Lacak status SKA Anda',
        icon: Icons.track_changes,
        color: Colors.purple,
      ),
      QuickAccessItem(
        title: 'FAQ',
        subtitle: 'Pertanyaan yang sering diajukan',
        icon: Icons.help_outline,
        color: Colors.teal,
      ),
    ];
  }

  Future<List<SkaItem>> getRecentSkaItems({int limit = 5}) async {
    await _simulateDelay();
    
    final allItems = [
      SkaItem(
        nomorAju: 'ID202508040261',
        nomorSKA: '0038799/JKT/2025',
        tanggal: '04 Agustus 2025 - 14:21 WIB',
        status: 'Terkirim',
      ),
      SkaItem(
        nomorAju: 'ID202508040688',
        nomorSKA: '0074019/SBY/2025',
        tanggal: '04 Agustus 2025 - 13:45 WIB',
        status: 'Terkirim',
      ),
      SkaItem(
        nomorAju: 'ID202508040806',
        nomorSKA: '0005570/KDM/2025',
        tanggal: '04 Agustus 2025 - 11:30 WIB',
        status: 'Terkirim',
      ),
      SkaItem(
        nomorAju: 'ID202508030945',
        nomorSKA: '0012345/BDG/2025',
        tanggal: '03 Agustus 2025 - 16:15 WIB',
        status: 'Terkirim',
      ),
      SkaItem(
        nomorAju: 'ID202508031234',
        nomorSKA: '0067890/MLG/2025',
        tanggal: '03 Agustus 2025 - 10:20 WIB',
        status: 'Pending',
      ),
    ];
    
    return allItems.take(limit).toList();
  }

  Future<List<NewsItem>> getNews({int limit = 10}) async {
    await _simulateDelay();
    
    final allNews = [
      NewsItem(
        id: '1',
        title: 'Pelepasan Ekspor Produk Rempah ke Amerika Serikat',
        date: '03 Agustus 2025',
        imagePath: 'assets/images/berita1.jpg',
        content: 'Kementerian Perdagangan melakukan pelepasan ekspor produk rempah...',
        excerpt: 'Ekspor rempah Indonesia mencapai rekor tertinggi tahun ini',
      ),
      NewsItem(
        id: '2',
        title: 'UMKM Bali Ekspor Bersama Program BISA',
        date: '02 Agustus 2025',
        imagePath: 'assets/images/berita2.jpg',
        content: 'Program pemberdayaan UMKM Bali melalui skema ekspor bersama...',
        excerpt: 'Lebih dari 100 UMKM Bali bergabung dalam program ekspor',
      ),
      NewsItem(
        id: '3',
        title: 'Digitalisasi Layanan SKA Meningkat 200%',
        date: '01 Agustus 2025',
        imagePath: 'assets/images/berita3.jpg',
        content: 'Penggunaan layanan digital SKA mengalami peningkatan signifikan...',
        excerpt: 'Layanan digital SKA semakin diminati eksportir Indonesia',
      ),
      NewsItem(
        id: '4',
        title: 'Workshop Ekspor untuk UMKM Jawa Timur',
        date: '31 Juli 2025',
        imagePath: 'assets/images/berita4.jpg',
        content: 'Kemendag menggelar workshop khusus UMKM Jawa Timur...',
        excerpt: 'Ratusan UMKM antusias mengikuti workshop ekspor',
      ),
    ];
    
    return allNews.take(limit).toList();
  }

  Future<int> getTotalSkaThisMonth() async {
    await _simulateDelay();
    return 25847; // Simulated total
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    await _simulateDelay();
    
    return {
      'totalSkaThisMonth': 25847,
      'totalSkaThisYear': 298456,
      'activExporters': 15623,
      'pendingSka': 127,
    };
  }
}