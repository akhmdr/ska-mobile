import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';
import 'package:ska_mobile/core/widgets/custom_app_bar.dart';
import '../../data/eksportir/data_eksportir_dummy.dart';
import 'detail_eksportir_page.dart';

class DataEksportirPage extends StatefulWidget {
  const DataEksportirPage({super.key});

  @override
  State<DataEksportirPage> createState() => _DataEksportirPageState();
}

class _DataEksportirPageState extends State<DataEksportirPage> {
  final TextEditingController _namaPerusahaanController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredEksportirList = [];
  bool isLoading = false;

  String? _selectedStatus;
  String? _selectedKantor;
  bool _showAdvancedFilter = false;

  @override
  void initState() {
    super.initState();
    filteredEksportirList = List<Map<String, String>>.from(dummyEksportirList);
    _namaPerusahaanController.addListener(_filterList);
  }

  @override
  void dispose() {
    _namaPerusahaanController.removeListener(_filterList);
    _namaPerusahaanController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterList() {
    final query = _namaPerusahaanController.text.toLowerCase();
    setState(() {
      filteredEksportirList =
          dummyEksportirList.where((eks) {
            final perusahaan = (eks["perusahaan"] ?? "").toLowerCase();
            return perusahaan.contains(query);
          }).toList();
    });
  }

  void _onSearchPressed() {
    if (filteredEksportirList.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data tidak ditemukan')));
    }
  }

  void _onResetPressed() {
    _namaPerusahaanController.clear();
    setState(() {
      filteredEksportirList = List<Map<String, String>>.from(
        dummyEksportirList,
      );
      _selectedStatus = null;
      _selectedKantor = null;
    });
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.primaryColor),
        const SizedBox(width: 6),
        Text(
          "$label: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.normal),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEksportirCard(Map<String, String> eks) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailEksportirPage(
                perusahaan: eks["perusahaan"] ?? "",
                nib: eks["nib"] ?? "",
                npwp: eks["npwp"] ?? "",
                alamat: eks["alamat"] ?? "",
                kantor: eks["kantor"] ?? "",
                status: eks["status"] ?? "",
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      eks["perusahaan"] ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(eks["status"] ?? ""),
                    backgroundColor: Colors.green[100],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildDetailItem("NIB", eks["nib"] ?? "", Icons.confirmation_number),
              const SizedBox(height: 6),
              _buildDetailItem("NPWP", eks["npwp"] ?? "", Icons.account_balance),
              const SizedBox(height: 6),
              _buildDetailItem("Alamat", eks["alamat"] ?? "", Icons.location_on),
              const SizedBox(height: 6),
              _buildDetailItem("Kantor IPSKA", eks["kantor"] ?? "", Icons.business),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(title: "Data Eksportir"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _namaPerusahaanController.text = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    _showAdvancedFilter ? Icons.filter_list_off : Icons.filter_list,
                    color: AppTheme.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _showAdvancedFilter = !_showAdvancedFilter;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: _showAdvancedFilter,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _namaPerusahaanController,
                        decoration: InputDecoration(
                          labelText: "Nama Perusahaan",
                          labelStyle: TextStyle(color: AppTheme.primaryColor),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "NIB",
                          labelStyle: TextStyle(color: AppTheme.primaryColor),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "NPWP",
                          labelStyle: TextStyle(color: AppTheme.primaryColor),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        decoration: InputDecoration(
                          labelText: "Status Perusahaan",
                          labelStyle: TextStyle(color: AppTheme.primaryColor),
                          border: const OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: "Aktif", child: Text("Aktif")),
                          DropdownMenuItem(
                            value: "Tidak Aktif",
                            child: Text("Tidak Aktif"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedKantor,
                        decoration: InputDecoration(
                          labelText: "Kantor IPSKA",
                          labelStyle: TextStyle(color: AppTheme.primaryColor),
                          border: const OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Kab. Bogor",
                            child: Text("Kab. Bogor"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedKantor = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Provinsi",
                                labelStyle: TextStyle(
                                  color: AppTheme.primaryColor,
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Kabupaten",
                                labelStyle: TextStyle(
                                  color: AppTheme.primaryColor,
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: _onSearchPressed,
                            child: const Text("Cari"),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: _onResetPressed,
                            child: const Text("Reset"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child:
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : filteredEksportirList.isEmpty
                      ? const Center(child: Text("Tidak ditemukan"))
                      : ListView.builder(
                        itemCount: filteredEksportirList.length,
                        itemBuilder: (context, index) {
                          final eks = filteredEksportirList[index];
                          return _buildEksportirCard(eks);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}