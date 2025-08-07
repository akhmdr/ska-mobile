// lib/data/services/dab_service.dart
import '../../core/models/dab_models.dart';

class DabService {
  static DabService? _instance;
  DabService._internal();
  
  static DabService get instance {
    _instance ??= DabService._internal();
    return _instance!;
  }

  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<List<DabItem>> getAllDabItems() async {
    await _simulateDelay();
    
    return [
      DabItem(
        id: '1',
        perusahaan: 'PT. EXPORTINDO MAJU BERSAMA',
        importir: 'GOLDEN HARVEST TRADING CO',
        tipe: 'I',
        kantor: 'KPU JAKARTA',
        tanggal: '15 Juli 2025',
        status: 'Sudah',
        nomorDab: 'DAB-2025-001234',
        nomorInvoice: 'INV-2025-5678',
      ),
      DabItem(
        id: '2',
        perusahaan: 'CV. SPICE INDONESIA',
        importir: 'ASIA PACIFIC IMPORTS',
        tipe: 'II',
        kantor: 'KPU SURABAYA',
        tanggal: '20 Juli 2025',
        status: 'Belum',
        nomorDab: 'DAB-2025-001235',
        nomorInvoice: 'INV-2025-5679',
      ),
      DabItem(
        id: '3',
        perusahaan: 'PT. REMPAH NUSANTARA',
        importir: 'EUROPEAN SPICE COMPANY',
        tipe: 'I',
        kantor: 'KPU MEDAN',
        tanggal: '22 Juli 2025',
        status: 'Sudah',
        nomorDab: 'DAB-2025-001236',
        nomorInvoice: 'INV-2025-5680',
      ),
      DabItem(
        id: '4',
        perusahaan: 'UD. SARI LAUT',
        importir: 'OCEANIC TRADING LLC',
        tipe: 'III',
        kantor: 'KPU MAKASSAR',
        tanggal: '25 Juli 2025',
        status: 'Proses',
        nomorDab: 'DAB-2025-001237',
        nomorInvoice: 'INV-2025-5681',
      ),
      DabItem(
        id: '5',
        perusahaan: 'PT. AGRO MANDIRI',
        importir: 'CONTINENTAL FOOD IMPORTS',
        tipe: 'II',
        kantor: 'KPU SEMARANG',
        tanggal: '28 Juli 2025',
        status: 'Belum',
        nomorDab: 'DAB-2025-001238',
        nomorInvoice: 'INV-2025-5682',
      ),
      DabItem(
        id: '6',
        perusahaan: 'CV. TROPICAL FRUITS',
        importir: 'FRESH WORLD TRADING',
        tipe: 'I',
        kantor: 'KPU DENPASAR',
        tanggal: '30 Juli 2025',
        status: 'Sudah',
        nomorDab: 'DAB-2025-001239',
        nomorInvoice: 'INV-2025-5683',
      ),
      DabItem(
        id: '7',
        perusahaan: 'PT. KOPI ARABIKA INDONESIA',
        importir: 'AMERICAN COFFEE IMPORTS',
        tipe: 'II',
        kantor: 'KPU BANDUNG',
        tanggal: '01 Agustus 2025',
        status: 'Belum',
        nomorDab: 'DAB-2025-001240',
        nomorInvoice: 'INV-2025-5684',
      ),
      DabItem(
        id: '8',
        perusahaan: 'UD. HASIL BUMI',
        importir: 'NATURAL PRODUCTS TRADING',
        tipe: 'III',
        kantor: 'KPU PALEMBANG',
        tanggal: '03 Agustus 2025',
        status: 'Sudah',
        nomorDab: 'DAB-2025-001241',
        nomorInvoice: 'INV-2025-5685',
      ),
    ];
  }

  Future<List<DabItem>> searchDabItems({
    String? query,
    DabFilter? filter,
  }) async {
    final allItems = await getAllDabItems();
    
    var filteredItems = allItems;
    
    // Apply search query
    if (query != null && query.isNotEmpty) {
      filteredItems = filteredItems.where((item) => item.matchesSearch(query)).toList();
    }
    
    // Apply filters
    if (filter != null && filter.hasActiveFilters) {
      filteredItems = filteredItems.where((item) => item.matchesFilters(filter)).toList();
    }
    
    return filteredItems;
  }

  Future<List<String>> getTipeOptions() async {
    return ['I', 'II', 'III'];
  }

  Future<List<String>> getStatusOptions() async {
    return ['Sudah', 'Belum', 'Proses'];
  }

  Future<List<String>> getKantorOptions() async {
    return [
      'KPU JAKARTA',
      'KPU SURABAYA',
      'KPU MEDAN',
      'KPU MAKASSAR',
      'KPU SEMARANG',
      'KPU DENPASAR',
      'KPU BANDUNG',
      'KPU PALEMBANG',
    ];
  }

  Future<Map<String, dynamic>> getDabStats() async {
    await _simulateDelay();
    
    return {
      'totalDab': 156,
      'dabSudah': 89,
      'dabBelum': 45,
      'dabProses': 22,
    };
  }
}