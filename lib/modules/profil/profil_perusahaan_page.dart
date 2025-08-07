import 'package:flutter/material.dart';

// Data Models
class CompanyProfile {
  final AccountInfo accountInfo;
  final CompanyAddress companyAddress;
  final FactoryWarehouse factoryWarehouse;

  CompanyProfile({
    required this.accountInfo,
    required this.companyAddress,
    required this.factoryWarehouse,
  });
}

class AccountInfo {
  final String name;
  final String companyName;
  final String nib;
  final String npwp;
  final String officeType;
  final String ipskaOffice;
  final String username;
  final String email;
  final String role;
  final String status;

  AccountInfo({
    required this.name,
    required this.companyName,
    required this.nib,
    required this.npwp,
    required this.officeType,
    required this.ipskaOffice,
    required this.username,
    required this.email,
    required this.role,
    required this.status,
  });
}

class CompanyAddress {
  final String address;
  final String province;
  final String city;
  final String district;
  final String subDistrict;
  final String postalCode;

  CompanyAddress({
    required this.address,
    required this.province,
    required this.city,
    required this.district,
    required this.subDistrict,
    required this.postalCode,
  });
}

class FactoryWarehouse {
  final String address;
  final String province;
  final String city;

  FactoryWarehouse({
    required this.address,
    required this.province,
    required this.city,
  });
}

class ProfilPerusahaanPage extends StatefulWidget {
  const ProfilPerusahaanPage({super.key});

  @override
  State<ProfilPerusahaanPage> createState() => _ProfilPerusahaanPageState();
}

class _ProfilPerusahaanPageState extends State<ProfilPerusahaanPage> {
  CompanyProfile? _companyProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCompanyProfile();
  }

  // Simulate API call
  Future<void> _loadCompanyProfile() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    setState(() {
      _companyProfile = CompanyProfile(
        accountInfo: AccountInfo(
          name: 'DEMO EKSPORTIR',
          companyName: 'PT DEMO EKSPORTIR',
          nib: '1234567891234',
          npwp: '123456789012098',
          officeType: 'Kantor Pusat',
          ipskaOffice: 'IPSKA DITFAS',
          username: 'eksportirdemo',
          email: 'demoeksportir@gmail.com',
          role: 'Demo Eksportir',
          status: 'Aktif',
        ),
        companyAddress: CompanyAddress(
          address: 'KP BATULAWANG RT.001 RW.028',
          province: 'JAWA BARAT',
          city: 'BANDUNG',
          district: 'Ciwidey',
          subDistrict: 'Ciwidey',
          postalCode: '12345',
        ),
        factoryWarehouse: FactoryWarehouse(
          address: 'Jalan Panjang AKR Tower',
          province: 'DKI JAKARTA',
          city: 'KOTA ADM. JAKARTA BARAT',
        ),
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo[600],
        foregroundColor: Colors.white,
        title: const Text(
          'Profil Perusahaan',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: _isLoading ? _buildLoadingState() : _buildContent(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat data profil...'),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_companyProfile == null) {
      return const Center(child: Text('Data tidak tersedia'));
    }

    return RefreshIndicator(
      onRefresh: _loadCompanyProfile,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAccountInfoSection(),
          const SizedBox(height: 24),
          _buildCompanyAddressSection(),
          const SizedBox(height: 24),
          _buildFactoryWarehouseSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildAccountInfoSection() {
    final accountInfo = _companyProfile!.accountInfo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Info Akun', Icons.account_circle, Colors.blue),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildInfoRow(Icons.person, 'Nama', accountInfo.name),
              _buildDivider(),
              _buildInfoRow(
                Icons.business,
                'Perusahaan',
                accountInfo.companyName,
              ),
              _buildDivider(),
              _buildInfoRow(Icons.numbers, 'NIB', accountInfo.nib),
              _buildDivider(),
              _buildInfoRow(Icons.receipt_long, 'NPWP', accountInfo.npwp),
              _buildDivider(),
              _buildInfoRow(
                Icons.business_center,
                'Tipe Kantor',
                accountInfo.officeType,
              ),
              _buildDivider(),
              _buildInfoRow(
                Icons.location_city,
                'Kantor IPSKA',
                accountInfo.ipskaOffice,
              ),
              _buildDivider(),
              _buildInfoRow(
                Icons.account_box,
                'Username',
                accountInfo.username,
              ),
              _buildDivider(),
              _buildInfoRow(Icons.email, 'Email', accountInfo.email),
              _buildDivider(),
              _buildInfoRow(
                Icons.admin_panel_settings,
                'Role User',
                accountInfo.role,
              ),
              _buildDivider(),
              _buildStatusRow(accountInfo.status),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyAddressSection() {
    final address = _companyProfile!.companyAddress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Alamat Perusahaan',
          Icons.location_on,
          Colors.green,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildInfoRow(Icons.home, 'Alamat', address.address),
              _buildDivider(),
              _buildInfoRow(Icons.map, 'Provinsi', address.province),
              _buildDivider(),
              _buildInfoRow(
                Icons.location_city,
                'Kota/Kabupaten',
                address.city,
              ),
              _buildDivider(),
              _buildInfoRow(Icons.place, 'Kecamatan', address.district),
              _buildDivider(),
              _buildInfoRow(Icons.home_work, 'Kelurahan', address.subDistrict),
              _buildDivider(),
              _buildInfoRow(
                Icons.local_post_office,
                'Kode Pos',
                address.postalCode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFactoryWarehouseSection() {
    final factory = _companyProfile!.factoryWarehouse;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Pabrik / Gudang', Icons.factory, Colors.orange),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildInfoRow(Icons.home, 'Alamat', factory.address),
              _buildDivider(),
              _buildInfoRow(Icons.map, 'Provinsi', factory.province),
              _buildDivider(),
              _buildInfoRow(
                Icons.location_city,
                'Kota/Kabupaten',
                factory.city,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String status) {
    final isActive = status.toLowerCase() == 'aktif';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.verified, size: 16, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text(
              'Status',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? Colors.green[200]! : Colors.red[200]!,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.green[700] : Colors.red[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }
}
