// lib/modules/dab/penerbitan_dab_page.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/models/dab_models.dart';
import '../../data/services/dab_service.dart';
import 'detail_penerbitan_dab_page.dart';

class PenerbitanDABPage extends StatefulWidget {
  const PenerbitanDABPage({Key? key}) : super(key: key);

  @override
  State<PenerbitanDABPage> createState() => _PenerbitanDABPageState();
}

class _PenerbitanDABPageState extends State<PenerbitanDABPage> {
  final DabService _dabService = DabService.instance;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nomorDabController = TextEditingController();
  final TextEditingController _namaImportirController = TextEditingController();
  final TextEditingController _nomorInvoiceController = TextEditingController();

  List<DabItem> _allDabItems = [];
  List<DabItem> _filteredDabItems = [];
  DabFilter _currentFilter = DabFilter.empty();
  bool _isLoading = true;
  bool _isFilterExpanded = false;
  String _searchQuery = '';

  List<String> _tipeOptions = [];
  List<String> _statusOptions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nomorDabController.dispose();
    _namaImportirController.dispose();
    _nomorInvoiceController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _dabService.getAllDabItems(),
        _dabService.getTipeOptions(),
        _dabService.getStatusOptions(),
      ]);

      if (mounted) {
        setState(() {
          _allDabItems = results[0] as List<DabItem>;
          _tipeOptions = results[1] as List<String>;
          _statusOptions = results[2] as List<String>;
          _filteredDabItems = _allDabItems;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Gagal memuat data DAB');
      }
    }
  }

  Future<void> _applyFilters() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _dabService.searchDabItems(
        query: _searchQuery,
        filter: _currentFilter,
      );

      if (mounted) {
        setState(() {
          _filteredDabItems = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Gagal mencari data DAB');
      }
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  void _resetFilters() {
    setState(() {
      _currentFilter = DabFilter.empty();
      _searchQuery = '';
      _searchController.clear();
      _nomorDabController.clear();
      _namaImportirController.clear();
      _nomorInvoiceController.clear();
    });
    _applyFilters();
  }

  void _toggleFilterExpansion() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        title: 'Penerbitan DAB',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showSuccessSnackBar('Buat DAB baru diklik'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilterSection(),
          if (_currentFilter.hasActiveFilters) _buildActiveFilterChips(),
          Expanded(child: _isLoading ? _buildLoadingState() : _buildDabList()),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat data DAB...'),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText:
                          'Cari berdasarkan perusahaan, importir, nomor...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color:
                        _currentFilter.hasActiveFilters
                            ? AppTheme.primaryColor
                            : AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          _currentFilter.hasActiveFilters
                              ? AppTheme.primaryColor
                              : Colors.grey[300]!,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isFilterExpanded
                          ? Icons.filter_list_off
                          : Icons.filter_list,
                      color:
                          _currentFilter.hasActiveFilters
                              ? AppTheme.onPrimaryColor
                              : AppTheme.primaryColor,
                    ),
                    onPressed: _toggleFilterExpansion,
                  ),
                ),
                if (_currentFilter.hasActiveFilters) ...[
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.errorColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.errorColor),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.clear, color: AppTheme.errorColor),
                      onPressed: _resetFilters,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Expandable Filter Section
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isFilterExpanded ? null : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isFilterExpanded ? 1.0 : 0.0,
              child:
                  _isFilterExpanded
                      ? _buildExpandedFilters()
                      : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedFilters() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Filter Lanjutan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          // Row 1: Tipe DAB and Status
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _currentFilter.tipe,
                  decoration: const InputDecoration(
                    labelText: 'Tipe DAB',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      _tipeOptions.map((tipe) {
                        return DropdownMenuItem(value: tipe, child: Text(tipe));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentFilter = _currentFilter.copyWith(tipe: value);
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _currentFilter.status,
                  decoration: const InputDecoration(
                    labelText: 'Status DAB',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      _statusOptions.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentFilter = _currentFilter.copyWith(status: value);
                    });
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Row 2: Nomor DAB and Nama Importir
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nomorDabController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor DAB',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _currentFilter = _currentFilter.copyWith(nomorDab: value);
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _namaImportirController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Importir',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _currentFilter = _currentFilter.copyWith(
                        namaImportir: value,
                      );
                    });
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Row 3: Nomor Invoice
          TextField(
            controller: _nomorInvoiceController,
            decoration: const InputDecoration(
              labelText: 'Nomor Invoice',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _currentFilter = _currentFilter.copyWith(nomorInvoice: value);
              });
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Aktif (${_currentFilter.activeFilterCount})',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children:
                _currentFilter.activeFilterLabels.map((label) {
                  return Chip(
                    label: Text(label, style: const TextStyle(fontSize: 12)),
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    side: const BorderSide(color: AppTheme.primaryColor),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDabList() {
    if (_filteredDabItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Tidak ada data DAB ditemukan',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Coba ubah kata kunci atau filter pencarian',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _filteredDabItems.length,
        itemBuilder: (context, index) {
          final dab = _filteredDabItems[index];
          return _buildDabCard(dab);
        },
      ),
    );
  }

  Widget _buildDabCard(DabItem dab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DetailPenerbitanDABPage()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with company name and status
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dab.perusahaan,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onBackgroundColor,
                      ),
                    ),
                  ),
                  _StatusBadge(status: dab.status),
                ],
              ),

              const SizedBox(height: 12),

              // Importir info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.business, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Importir: ${dab.importir}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Details grid
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      'Tipe DAB',
                      dab.tipe,
                      Icons.category,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailItem(
                      'Kantor',
                      dab.kantor,
                      Icons.location_on,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      'No. DAB',
                      dab.nomorDab,
                      Icons.confirmation_number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailItem(
                      'Tanggal',
                      dab.tanggal,
                      Icons.calendar_today,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppTheme.primaryColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.onBackgroundColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'sudah':
        backgroundColor = AppTheme.successColor.withOpacity(0.1);
        textColor = AppTheme.successColor;
        icon = Icons.check_circle;
        break;
      case 'belum':
        backgroundColor = AppTheme.warningColor.withOpacity(0.1);
        textColor = AppTheme.warningColor;
        icon = Icons.pending;
        break;
      case 'proses':
        backgroundColor = AppTheme.infoColor.withOpacity(0.1);
        textColor = AppTheme.infoColor;
        icon = Icons.sync;
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
