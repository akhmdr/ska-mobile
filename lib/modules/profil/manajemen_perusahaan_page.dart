import 'package:flutter/material.dart';

class ManajemenPerusahaanPage extends StatelessWidget {
  const ManajemenPerusahaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          title: const Text(
            'Manajemen Perusahaan',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(icon: Icon(Icons.business), text: 'Data Perusahaan'),
              Tab(icon: Icon(Icons.people), text: 'Data User'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_DataPerusahaanTab(), _DataUserTab()],
        ),
      ),
    );
  }
}

class _DataPerusahaanTab extends StatelessWidget {
  const _DataPerusahaanTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.blue[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.business, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Data Perusahaan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildDataTable(),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    final dummyData = [
      {
        'nama': 'MUHAMMAD AFIF PRATAMA',
        'npwp': '9347548544450001',
        'ipska': 'IPSKA DITFAS',
        'tipe': 'Kantor Pusat',
        'status': 'Aktif',
        'tanggal': '19 April 2025 22:42',
      },
      {
        'nama': 'PT KOPI NUSANTARA',
        'npwp': '9876543210010002',
        'ipska': 'IPSKA BANDUNG',
        'tipe': 'Kantor Cabang',
        'status': 'Nonaktif',
        'tanggal': '10 Mei 2025 15:21',
      },
    ];

    return Column(
      children: List.generate(dummyData.length, (index) {
        final d = dummyData[index];
        final isActive = d['status'] == 'Aktif';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d['nama']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isActive ? Colors.green[50] : Colors.red[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    isActive
                                        ? Colors.green[200]!
                                        : Colors.red[200]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              d['status']!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color:
                                    isActive
                                        ? Colors.green[700]
                                        : Colors.red[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoRow(Icons.numbers, 'NPWP', d['npwp']!),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.location_city, 'Kantor IPSKA', d['ipska']!),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.business_center, 'Tipe', d['tipe']!),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.access_time,
                  'Terakhir Diubah',
                  d['tanggal']!,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DataUserTab extends StatelessWidget {
  const _DataUserTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[600]!, Colors.purple[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Data User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildUserTable(),
        ],
      ),
    );
  }

  Widget _buildUserTable() {
    final dummyData = [
      {
        'nama': 'MUHAMMAD AFIF PRATAMA',
        'tipe': 'Kantor Pusat',
        'pengguna': 'UD resi cabang testing ygy',
        'username': 'udresii',
        'role': 'Child Pusat Eksportir',
        'status': 'Aktif',
        'tanggal': '15 Januari 2025 14:35',
      },
      {
        'nama': 'MUHAMMAD AFIF PRATAMA',
        'tipe': 'Kantor Pusat',
        'pengguna': 'User Host 2 Host Test',
        'username': 'host2hosttest',
        'role': 'Child Pusat Eksportir',
        'status': 'Aktif',
        'tanggal': '15 Mei 2025 08:28',
      },
      {
        'nama': 'MUHAMMAD AFIF PRATAMA',
        'tipe': 'Kantor Pusat',
        'pengguna': 'TESTING SKA',
        'username': 'testingmagang',
        'role': 'Child Pusat Eksportir',
        'status': 'Aktif',
        'tanggal': '15 Januari 2025 14:35',
      },
      {
        'nama': 'MUHAMMAD AFIF PRATAMA',
        'tipe': 'Kantor Pusat',
        'pengguna': 'MUHAMMAD AFIF PRATAMA',
        'username': 'muhammad2223312022e',
        'role': 'Master Pusat Eksportir',
        'status': 'Aktif',
        'tanggal': '02 Agustus 2025 08:57',
      },
    ];

    return Column(
      children: List.generate(dummyData.length, (index) {
        final d = dummyData[index];
        final isActive = d['status'] == 'Aktif';
        final isMaster = d['role']!.contains('Master');

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:
                              isMaster
                                  ? [Colors.orange[400]!, Colors.orange[600]!]
                                  : [Colors.blue[400]!, Colors.blue[600]!],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d['nama']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isMaster
                                          ? Colors.orange[50]
                                          : Colors.blue[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        isMaster
                                            ? Colors.orange[200]!
                                            : Colors.blue[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  d['role']!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isMaster
                                            ? Colors.orange[700]
                                            : Colors.blue[700],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isActive
                                          ? Colors.green[50]
                                          : Colors.red[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        isActive
                                            ? Colors.green[200]!
                                            : Colors.red[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  d['status']!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isActive
                                            ? Colors.green[700]
                                            : Colors.red[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildUserInfoRow(
                  Icons.business,
                  'Tipe Perusahaan',
                  d['tipe']!,
                ),
                const SizedBox(height: 8),
                _buildUserInfoRow(
                  Icons.person,
                  'Nama Pengguna',
                  d['pengguna']!,
                ),
                const SizedBox(height: 8),
                _buildUserInfoRow(
                  Icons.account_circle,
                  'Username',
                  d['username']!,
                ),
                const SizedBox(height: 8),
                _buildUserInfoRow(
                  Icons.access_time,
                  'Terakhir Diubah',
                  d['tanggal']!,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
