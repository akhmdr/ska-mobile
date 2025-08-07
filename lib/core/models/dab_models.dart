// lib/core/models/dab_models.dart
class DabItem {
  final String id;
  final String perusahaan;
  final String importir;
  final String tipe;
  final String kantor;
  final String tanggal;
  final String status;
  final String nomorDab;
  final String nomorInvoice;
  final DateTime createdAt;

  DabItem({
    required this.id,
    required this.perusahaan,
    required this.importir,
    required this.tipe,
    required this.kantor,
    required this.tanggal,
    required this.status,
    required this.nomorDab,
    required this.nomorInvoice,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory DabItem.fromJson(Map<String, dynamic> json) {
    return DabItem(
      id: json['id'] ?? '',
      perusahaan: json['perusahaan'] ?? '',
      importir: json['importir'] ?? '',
      tipe: json['tipe'] ?? '',
      kantor: json['kantor'] ?? '',
      tanggal: json['tanggal'] ?? '',
      status: json['status'] ?? '',
      nomorDab: json['nomorDab'] ?? '',
      nomorInvoice: json['nomorInvoice'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'perusahaan': perusahaan,
      'importir': importir,
      'tipe': tipe,
      'kantor': kantor,
      'tanggal': tanggal,
      'status': status,
      'nomorDab': nomorDab,
      'nomorInvoice': nomorInvoice,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool matchesSearch(String query) {
    if (query.isEmpty) return true;
    
    final searchLower = query.toLowerCase();
    return perusahaan.toLowerCase().contains(searchLower) ||
           importir.toLowerCase().contains(searchLower) ||
           nomorDab.toLowerCase().contains(searchLower) ||
           nomorInvoice.toLowerCase().contains(searchLower) ||
           tipe.toLowerCase().contains(searchLower) ||
           kantor.toLowerCase().contains(searchLower);
  }

  bool matchesFilters(DabFilter filter) {
    if (filter.tipe != null && tipe != filter.tipe) return false;
    if (filter.status != null && status != filter.status) return false;
    if (filter.nomorDab != null && filter.nomorDab!.isNotEmpty) {
      if (!nomorDab.toLowerCase().contains(filter.nomorDab!.toLowerCase())) {
        return false;
      }
    }
    if (filter.namaImportir != null && filter.namaImportir!.isNotEmpty) {
      if (!importir.toLowerCase().contains(filter.namaImportir!.toLowerCase())) {
        return false;
      }
    }
    if (filter.nomorInvoice != null && filter.nomorInvoice!.isNotEmpty) {
      if (!nomorInvoice.toLowerCase().contains(filter.nomorInvoice!.toLowerCase())) {
        return false;
      }
    }
    // Add date range filtering logic here if needed
    return true;
  }

  String get statusColor {
    switch (status.toLowerCase()) {
      case 'sudah':
        return 'success';
      case 'belum':
        return 'warning';
      case 'proses':
        return 'info';
      default:
        return 'default';
    }
  }
}

class DabFilter {
  final String? tipe;
  final String? nomorDab;
  final String? namaImportir;
  final String? nomorInvoice;
  final DateTime? tanggalMulai;
  final DateTime? tanggalSelesai;
  final String? status;

  DabFilter({
    this.tipe,
    this.nomorDab,
    this.namaImportir,
    this.nomorInvoice,
    this.tanggalMulai,
    this.tanggalSelesai,
    this.status,
  });

  bool get hasActiveFilters {
    return tipe != null ||
           (nomorDab != null && nomorDab!.isNotEmpty) ||
           (namaImportir != null && namaImportir!.isNotEmpty) ||
           (nomorInvoice != null && nomorInvoice!.isNotEmpty) ||
           tanggalMulai != null ||
           tanggalSelesai != null ||
           status != null;
  }

  int get activeFilterCount {
    int count = 0;
    if (tipe != null) count++;
    if (nomorDab != null && nomorDab!.isNotEmpty) count++;
    if (namaImportir != null && namaImportir!.isNotEmpty) count++;
    if (nomorInvoice != null && nomorInvoice!.isNotEmpty) count++;
    if (tanggalMulai != null) count++;
    if (tanggalSelesai != null) count++;
    if (status != null) count++;
    return count;
  }

  List<String> get activeFilterLabels {
    List<String> labels = [];
    if (tipe != null) labels.add('Tipe: $tipe');
    if (nomorDab != null && nomorDab!.isNotEmpty) labels.add('No. DAB');
    if (namaImportir != null && namaImportir!.isNotEmpty) labels.add('Importir');
    if (nomorInvoice != null && nomorInvoice!.isNotEmpty) labels.add('Invoice');
    if (tanggalMulai != null || tanggalSelesai != null) labels.add('Tanggal');
    if (status != null) labels.add('Status: $status');
    return labels;
  }

  DabFilter copyWith({
    String? tipe,
    String? nomorDab,
    String? namaImportir,
    String? nomorInvoice,
    DateTime? tanggalMulai,
    DateTime? tanggalSelesai,
    String? status,
    bool clearTipe = false,
    bool clearNomorDab = false,
    bool clearNamaImportir = false,
    bool clearNomorInvoice = false,
    bool clearTanggalMulai = false,
    bool clearTanggalSelesai = false,
    bool clearStatus = false,
  }) {
    return DabFilter(
      tipe: clearTipe ? null : (tipe ?? this.tipe),
      nomorDab: clearNomorDab ? null : (nomorDab ?? this.nomorDab),
      namaImportir: clearNamaImportir ? null : (namaImportir ?? this.namaImportir),
      nomorInvoice: clearNomorInvoice ? null : (nomorInvoice ?? this.nomorInvoice),
      tanggalMulai: clearTanggalMulai ? null : (tanggalMulai ?? this.tanggalMulai),
      tanggalSelesai: clearTanggalSelesai ? null : (tanggalSelesai ?? this.tanggalSelesai),
      status: clearStatus ? null : (status ?? this.status),
    );
  }

  static DabFilter empty() {
    return DabFilter();
  }
}