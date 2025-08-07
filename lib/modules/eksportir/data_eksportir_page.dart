import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';
import 'package:ska_mobile/modules/eksportir/detail_eksportir_page.dart';

class DataEksportirPage extends StatefulWidget {
  const DataEksportirPage({super.key});

  @override
  State<DataEksportirPage> createState() => _DataEksportirPageState();
}

class _DataEksportirPageState extends State<DataEksportirPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFilterExpanded = false;

  final List<Map<String, String>> _data = [
    {
      'nama': 'PT SPCIFICA DTR INTERNATIONAL',
      'nib': '0210504432828',
      'npwp': '322654400030200',
      'alamat': 'Jl. Raya Jakarta Bogor KM 47,5',
      'kantor': 'Kab. Bogor',
      'status': 'Aktif',
    },
    {
      'nama': 'PT MURAKAMI DOLIDY INDONESIA',
      'nib': '281000784441',
      'npwp': '089654400056000',
      'alamat': 'Kawasan Greenland Industrial Center',
      'kantor': 'Kab. Purwakarta',
      'status': 'Aktif',
    },
  ];

  String? _filterStatus;
  String? _filterKantor;

  void _toggleFilter() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
    });
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _filterStatus = null;
      _filterKantor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Data Eksportir'),
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final e = _data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => DetailEksportirPage(
                              perusahaan: e['nama']!,
                              nib: e['nib']!,
                              npwp: e['npwp']!,
                              alamat: e['alamat']!,
                              kantor: e['kantor']!,
                              status: e['status']!,
                            ),
                      ),
                    );
                  },
                  child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                e['nama']!,
                                style: AppTheme.textBold14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                e['status']!,
                                style: AppTheme.textRegular13.copyWith(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(Icons.badge_outlined, 'NIB', e['nib']!),
                        _buildInfoRow(
                          Icons.account_balance,
                          'NPWP',
                          e['npwp']!,
                        ),
                        _buildInfoRow(
                          Icons.location_on_outlined,
                          'Alamat',
                          e['alamat']!,
                        ),
                        _buildInfoRow(
                          Icons.apartment,
                          'Kantor IPSKA',
                          e['kantor']!,
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

  Widget _buildSearchAndFilter() {
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
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) {},
                    decoration: InputDecoration(
                      hintText: 'Cari berdasarkan nama perusahaan...',
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
                        _isFilterExpanded
                            ? AppTheme.primaryColor
                            : AppTheme.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          _isFilterExpanded
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
                          _isFilterExpanded
                              ? Colors.white
                              : AppTheme.primaryColor,
                    ),
                    onPressed: _toggleFilter,
                  ),
                ),
              ],
            ),
          ),

          // Expandable filters
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isFilterExpanded ? null : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isFilterExpanded ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Filter Lanjutan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown(
                      'Status Perusahaan',
                      ['Aktif', 'Tidak Aktif'],
                      _filterStatus,
                      (val) => setState(() => _filterStatus = val),
                    ),
                    const SizedBox(height: 12),
                    _buildDropdown(
                      'Kantor IPSKA',
                      ['Kab. Bogor', 'Kab. Purwakarta'],
                      _filterKantor,
                      (val) => setState(() => _filterKantor = val),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Filter diterapkan'),
                                ),
                              );
                            },
                            child: const Text('Terapkan Filter'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _resetFilters,
                            child: const Text('Reset'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selected,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      items:
          items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Text('$label: ', style: AppTheme.textBold13),
          Expanded(child: Text(value, style: AppTheme.textRegular13)),
        ],
      ),
    );
  }
}
