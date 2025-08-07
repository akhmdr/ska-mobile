import 'package:flutter/material.dart';
import 'package:ska_mobile/core/theme/app_theme.dart';

class HubungiKamiTab extends StatefulWidget {
  const HubungiKamiTab({super.key});

  @override
  State<HubungiKamiTab> createState() => _HubungiKamiTabState();
}

class _HubungiKamiTabState extends State<HubungiKamiTab> {
  final _formKey = GlobalKey<FormState>();

  String? selectedForm;
  String? selectedTicket;

  final List<String> formList = ['SKA', 'DAB', 'Lainnya'];
  final List<String> ticketList = ['Permasalahan Teknis', 'Akun', 'Informasi', 'Lainnya'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextInput('Nama Lengkap', Icons.person),
            _buildTextInput('Email', Icons.email),
            _buildTextInput('NPWP', Icons.badge),
            _buildTextInput('NIB', Icons.confirmation_number),
            _buildDropdown('Form yang digunakan', formList, selectedForm, (val) {
              setState(() => selectedForm = val);
            }, Icons.description),
            _buildDropdown('Jenis Tiket', ticketList, selectedTicket, (val) {
              setState(() => selectedTicket = val);
            }, Icons.report_problem_outlined),
            _buildTextInput('Subjek', Icons.subject),
            _buildTextInput('Deskripsi', Icons.message, maxLines: 3),

            const SizedBox(height: 16),
            _buildUploadButton(),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildPrimaryButton('Kirim Pesan', Icons.send, onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pesan berhasil dikirim!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppTheme.primaryColor,
                      ),
                    );
                  }
                })),
                const SizedBox(width: 12),
                Expanded(child: _buildOutlineButton('Batal', Icons.refresh, onPressed: () {
                  _formKey.currentState?.reset();
                  setState(() {
                    selectedForm = null;
                    selectedTicket = null;
                  });
                })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput(String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: AppTheme.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selected,
    Function(String?) onChanged,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selected,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: AppTheme.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildUploadButton() {
    return OutlinedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fungsi upload belum diimplementasikan.'),
            backgroundColor: AppTheme.primaryColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      icon: const Icon(Icons.upload_file),
      label: const Text('Upload File'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        side: const BorderSide(color: AppTheme.primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  Widget _buildPrimaryButton(String label, IconData icon, {required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildOutlineButton(String label, IconData icon, {required VoidCallback onPressed}) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        side: const BorderSide(color: AppTheme.primaryColor),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}