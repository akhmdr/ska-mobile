// lib/core/models/models.dart
import 'package:flutter/material.dart';

class QuickAccessItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  QuickAccessItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  factory QuickAccessItem.fromJson(Map<String, dynamic> json) {
    return QuickAccessItem(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      icon: IconData(json['iconCode'] ?? Icons.help.codePoint, fontFamily: 'MaterialIcons'),
      color: Color(json['colorValue'] ?? Colors.blue.value),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'iconCode': icon.codePoint,
      'colorValue': color.value,
    };
  }
}

class SkaItem {
  final String nomorAju;
  final String nomorSKA;
  final String tanggal;
  final String status;
  final DateTime createdAt;

  SkaItem({
    required this.nomorAju,
    required this.nomorSKA,
    required this.tanggal,
    this.status = 'Terkirim',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SkaItem.fromJson(Map<String, dynamic> json) {
    return SkaItem(
      nomorAju: json['nomorAju'] ?? '',
      nomorSKA: json['nomorSKA'] ?? '',
      tanggal: json['tanggal'] ?? '',
      status: json['status'] ?? 'Terkirim',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomorAju': nomorAju,
      'nomorSKA': nomorSKA,
      'tanggal': tanggal,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get statusColor {
    switch (status.toLowerCase()) {
      case 'terkirim':
        return 'success';
      case 'pending':
        return 'warning';
      case 'gagal':
        return 'error';
      default:
        return 'info';
    }
  }
}

class NewsItem {
  final String id;
  final String title;
  final String date;
  final String imagePath;
  final String? content;
  final String? excerpt;
  final DateTime createdAt;

  NewsItem({
    required this.id,
    required this.title,
    required this.date,
    required this.imagePath,
    this.content,
    this.excerpt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      imagePath: json['imagePath'] ?? '',
      content: json['content'],
      excerpt: json['excerpt'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'imagePath': imagePath,
      'content': content,
      'excerpt': excerpt,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class BannerItem {
  final String id;
  final String title;
  final String imagePath;
  final String? url;
  final bool isActive;

  BannerItem({
    required this.id,
    required this.title,
    required this.imagePath,
    this.url,
    this.isActive = true,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imagePath: json['imagePath'] ?? '',
      url: json['url'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'url': url,
      'isActive': isActive,
    };
  }
}