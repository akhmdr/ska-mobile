// lib/modules/tracking/tracking_page.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/app_button.dart';

import '../../core/models/ska_models.dart';
import '../../data/services/ska_service.dart';

// === Widgets kecil lokal (biar file ini self-contained) ======================

class _KV extends StatelessWidget {
  final String label, value;
  const _KV(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final SkaStatusType type;
  const _StatusBadge({required this.type});

  static String _label(SkaStatusType t) {
    switch (t) {
      case SkaStatusType.all:
        return 'ALL';
      case SkaStatusType.verifikasi:
        return 'VERIFIKASI';
      case SkaStatusType.requestRevisi:
        return 'REQUEST REVISI';
      case SkaStatusType.diprosesIpska:
        return 'DIPROSES IPSKA';
      case SkaStatusType.pengajuanCabutSka:
        return 'PENGAJUAN CABUT SKA';
      case SkaStatusType.ditolak:
        return 'DITOLAK';
      case SkaStatusType.diterbitkan:
        return 'DITERBITKAN';
      case SkaStatusType.pencabutan:
        return 'PENCABUTAN';
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = kSkaStatusColors[type]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: s.bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _label(type),
        style: TextStyle(
          color: s.fg,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DropdownChip extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _DropdownChip({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          filled: true,
          fillColor: AppTheme.backgroundColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: (value == null || value!.isEmpty) ? null : value,
            isExpanded: true,
            items:
                items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: onChanged,
            hint: const Text('Semua'),
          ),
        ),
      ),
    );
  }
}

class _StatusTabs extends StatelessWidget {
  final SkaStatusType current;
  final ValueChanged<SkaStatusType> onChanged;

  const _StatusTabs({required this.current, required this.onChanged});

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
      case SkaStatusType.all:
        return 'All';
      case SkaStatusType.verifikasi:
        return 'Verifikasi';
      case SkaStatusType.requestRevisi:
        return 'Request Revisi';
      case SkaStatusType.diprosesIpska:
        return 'Diproses IPSKA';
      case SkaStatusType.pengajuanCabutSka:
        return 'Pengajuan Cabut SKA';
      case SkaStatusType.ditolak:
        return 'Ditolak';
      case SkaStatusType.diterbitkan:
        return 'Diterbitkan';
      case SkaStatusType.pencabutan:
        return 'Pencabutan';
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
              duration: const Duration(milliseconds: 160),
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

class _AdvFilter {
  String? tipeForm, kantorIpska, negaraImportir, jenisTransportasi;
  void clear() {
    tipeForm = null;
    kantorIpska = null;
    negaraImportir = null;
    jenisTransportasi = null;
  }
}

// === Halaman utama ===========================================================

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final _service = SkaService();
  final _adv = _AdvFilter();

  List<SkaItem> _all = [];
  List<SkaItem> _view = [];
  SkaStatusType _status = SkaStatusType.all;
  String _keyword = ''; // hanya no_ska
  bool _loading = true;

  final _searchC = TextEditingController();
  bool _showFilters =
      false; // mengikuti gaya DAB: panel filter terlihat saat masuk

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final data = await _service.getAll();
    setState(() {
      _all = data;
      _apply();
      _loading = false;
    });
  }

  void _apply() {
    _view = _service.filter(
      _all,
      status: _status,
      keyword: _keyword, // service sudah membatasi ke no_ska
      tipeForm: _adv.tipeForm,
      kantorIpska: _adv.kantorIpska,
      negaraImportir: _adv.negaraImportir,
      jenisTransportasi: _adv.jenisTransportasi,
    );
    // Sort by latest tgl_kirim (descending)
    _view.sort((a, b) => _parseTglKirim(b).compareTo(_parseTglKirim(a)));
  }

  void _lihat(SkaItem it) {
    // TODO: arahkan ke DetailSKAPage sesuai routing proyekmu.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigasi ke Detail SKA (dummy)')),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  DateTime _parseTglKirim(SkaItem it) {
    final s = it.pengajuan.tglKirim;
    if (s == null || s.trim().isEmpty || s.trim() == '-') {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    final normalized = s.replaceFirst(' ', 'T'); // handle "YYYY-MM-DD HH:MM:SS"
    return DateTime.tryParse(normalized) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tracking SKA'),
      backgroundColor: AppTheme.scaffoldColor,
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Tabs status (scrollable, sticky)
          _StatusTabs(
            current: _status,
            onChanged:
                (t) => setState(() {
                  _status = t;
                  _apply();
                }),
          ),

          const SizedBox(height: 12),

          // Search hanya nomor SKA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchC,
                    onChanged:
                        (v) => setState(() {
                          _keyword = v.trim();
                          _apply();
                        }),
                    decoration: InputDecoration(
                      hintText: 'Cari nomor SKA…',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          _searchC.text.isEmpty
                              ? null
                              : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _searchC.clear();
                                  setState(() {
                                    _keyword = '';
                                    _apply();
                                  });
                                },
                              ),
                      filled: true,
                      fillColor: AppTheme.backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 48,
                  width: 48,
                  child: ElevatedButton(
                    onPressed:
                        () => setState(() => _showFilters = !_showFilters),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      backgroundColor: AppTheme.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Icon(
                      _showFilters ? Icons.filter_alt_off : Icons.filter_alt,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Filter Lanjutan
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:
                !_showFilters
                    ? const SizedBox.shrink()
                    : Container(
                      key: const ValueKey('filters'),
                      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filter Lanjutan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _DropdownChip(
                                label: 'Tipe Form',
                                value: _adv.tipeForm,
                                items: const [
                                  'FORM AK',
                                  'FORM AI',
                                  'FORM AANZ',
                                  'FORM D',
                                  'FORM B',
                                  'FORM RCEP',
                                  'FORM GSTP',
                                  'FORM IJEPA',
                                  'FORM AHKFTA',
                                ],
                                onChanged:
                                    (v) => setState(() {
                                      _adv.tipeForm = v;
                                      _apply();
                                    }),
                              ),
                              _DropdownChip(
                                label: 'Kantor IPSKA',
                                value: _adv.kantorIpska,
                                items: const ['DITFAS'],
                                onChanged:
                                    (v) => setState(() {
                                      _adv.kantorIpska = v;
                                      _apply();
                                    }),
                              ),
                              _DropdownChip(
                                label: 'Negara Importir',
                                value: _adv.negaraImportir,
                                items: const [
                                  'MALAYSIA',
                                  'REPUBLIC OF KOREA',
                                  'INDIA',
                                  'JAPAN',
                                  'ARGENTINA',
                                  'HONG KONG',
                                  'UNITED STATES OF AMERICA',
                                  'EGYPT',
                                  'THAILAND',
                                  'BANGLADESH',
                                ],
                                onChanged:
                                    (v) => setState(() {
                                      _adv.negaraImportir = v;
                                      _apply();
                                    }),
                              ),
                              _DropdownChip(
                                label: 'Transportasi',
                                value: _adv.jenisTransportasi,
                                items: const ['by SEA', 'by AIR'],
                                onChanged:
                                    (v) => setState(() {
                                      _adv.jenisTransportasi = v;
                                      _apply();
                                    }),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _adv.clear();
                                    _apply();
                                  });
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  size: 18,
                                  color: Color(0xFF7E57C2),
                                ),
                                label: const Text(
                                  'Reset',
                                  style: TextStyle(color: Color(0xFF7E57C2)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
          ),

          const SizedBox(height: 12),

          // List data
          Expanded(
            child:
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : _view.isEmpty
                    ? const Center(child: Text('Tidak ada hasil'))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _view.length,
                      itemBuilder: (_, i) {
                        final it = _view[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppTheme.cardShadow,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        it.pengajuan.noAju ?? '-',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    _StatusBadge(type: it.status.type),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                _KV(
                                  'Eksportir',
                                  (it.pengajuan.namaPerusahaan ??
                                          it.pengajuan.namaEksportir ??
                                          '')
                                      .toUpperCase(),
                                ),
                                _KV('Nomor SKA', it.pengajuan.noSka ?? '-'),
                                _KV(
                                  'Negara Importir',
                                  it.importir?.negaraImportir ?? '-',
                                ),
                                _KV(
                                  'Tgl Rencana Ekspor',
                                  it.importir?.tglRencanaEkspor ??
                                      it.pengajuan.tglKirim ??
                                      '-',
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppButton(
                                        label: 'Lihat',
                                        outlined: true,
                                        onPressed: () => _lihat(it),
                                        small: true,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: AppButton(
                                        label: 'Download',
                                        small: true,
                                        onPressed: () => _snack('Download belum tersedia (dummy)'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
