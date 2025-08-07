import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';

class KantorIpskaTab extends StatelessWidget {
  const KantorIpskaTab({super.key});

  final List<Map<String, String>> offices = const [
    {
      'name': 'IPSKA Jakarta',
      'address': 'Jl. Medan Merdeka Timur No. 7, Jakarta Pusat',
      'phone': '(021) 3456789',
    },
    {
      'name': 'IPSKA Surabaya',
      'address': 'Jl. Tunjungan No. 12, Surabaya',
      'phone': '(031) 4567890',
    },
    {
      'name': 'IPSKA Medan',
      'address': 'Jl. Gajah Mada No. 15, Medan',
      'phone': '(061) 5678901',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: offices.length,
      itemBuilder: (context, index) {
        final office = offices[index];
        return _buildOfficeCard(office, context);
      },
    );
  }

  Widget _buildOfficeCard(Map<String, String> office, BuildContext context) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(office['name']!, style: AppTheme.textBold14),
                const SizedBox(height: 4),
                Text(office['address']!, style: AppTheme.textRegular14),
                const SizedBox(height: 4),
                Text(office['phone']!, style: AppTheme.textRegular14),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.map_outlined, color: Colors.grey),
            onPressed: () {
              // TODO: implementasi buka Google Maps
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Membuka lokasi: ${office['name']}'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppTheme.primaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
