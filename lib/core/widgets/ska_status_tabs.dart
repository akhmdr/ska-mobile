import 'package:flutter/material.dart';
import '../models/ska_models.dart';

class SkaStatusTabs extends StatelessWidget {
  final SkaStatusType current;
  final ValueChanged<SkaStatusType> onChanged;

  const SkaStatusTabs({
    super.key,
    required this.current,
    required this.onChanged,
  });

  static const List<SkaStatusType> _items = [
    SkaStatusType.all,
    SkaStatusType.verifikasi,
    SkaStatusType.requestRevisi,
    SkaStatusType.diprosesIpska,
    SkaStatusType.pengajuanCabutSka,
    SkaStatusType.ditolak,
    SkaStatusType.diterbitkan,
    SkaStatusType.pencabutan,
  ];

  static String _label(SkaStatusType t) {
    switch (t) {
      case SkaStatusType.all: return 'All';
      case SkaStatusType.verifikasi: return 'Verifikasi';
      case SkaStatusType.requestRevisi: return 'Request Revisi';
      case SkaStatusType.diprosesIpska: return 'Diproses IPSKA';
      case SkaStatusType.pengajuanCabutSka: return 'Pengajuan Cabut SKA';
      case SkaStatusType.ditolak: return 'Ditolak';
      case SkaStatusType.diterbitkan: return 'Diterbitkan';
      case SkaStatusType.pencabutan: return 'Pencabutan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, i) {
          final t = _items[i];
          final sel = t == current;
          final style = kSkaStatusColors[t]!;
          return GestureDetector(
            onTap: () => onChanged(t),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: sel ? style.bg : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                _label(t),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: sel ? style.fg : Colors.black87,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: _items.length,
      ),
    );
  }
}