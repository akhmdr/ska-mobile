import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../core/models/ska_models.dart';

class SkaService {
  static const String _assetPath = 'assets/data/ska_dab_all_sorted.json';

  Future<List<SkaItem>> getAll() async {
    final raw = await rootBundle.loadString(_assetPath);
    final List<dynamic> list = jsonDecode(raw);

    return list.map<SkaItem>((e) {
      final pengajuan = e['pengajuan'] as Map<String, dynamic>;
      final importir  = (e['importir'] ?? {}) as Map<String, dynamic>;
      final form      = (e['form'] ?? {}) as Map<String, dynamic>;
      final statusMap = e['status'] as Map<String, dynamic>;

      return SkaItem(
        no: (e['no'] as num).toInt(),
        pengajuan: SkaPengajuan(
          namaPerusahaan: pengajuan['nama_perusahaan'] ?? pengajuan['nama_eksportir'],
          namaEksportir: pengajuan['nama_eksportir'],
          noAju: pengajuan['no_aju'],
          noSka: pengajuan['no_ska'],
          tglKirim: pengajuan['tgl_kirim'],
        ),
        importir: SkaImportir(
          namaImportir: importir['nama_importir'],
          negaraImportir: importir['negara_importir'],
          jenisTransportasi: importir['jenis_transportasi'],
          tglRencanaEkspor: importir['tgl_rencana_ekspor'],
        ),
        form: SkaForm(
          jenisForm: form['jenis_form'],
          tipeForm: form['tipe_form'],
          kantorIpska: form['kantor_ipska'],
          noInvoice: form['no_invoice'],
          noDocPabean: form['no_doc_pabean'],
        ),
        status: SkaStatus(
          type: parseSkaStatus(statusMap['status_pengajuan'] ?? ''),
          waktuStatus: statusMap['waktu_status'] ?? '',
          keterangan: statusMap['keterangan'],
        ),
      );
    }).toList();
  }

  List<SkaItem> filter(
    List<SkaItem> all, {
    SkaStatusType status = SkaStatusType.all,
    String keyword = '',                 // ← hanya no_ska
    String? tipeForm,
    String? kantorIpska,
    String? negaraImportir,
    String? jenisTransportasi,
  }) {
    final q = keyword.trim().toLowerCase();
    return all.where((it) {
      if (status != SkaStatusType.all && it.status.type != status) return false;

      // search hanya by no_ska
      final noSka = (it.pengajuan.noSka ?? '').toLowerCase();
      if (q.isNotEmpty && !noSka.contains(q)) return false;

      if (tipeForm?.isNotEmpty == true && (it.form?.tipeForm ?? '') != tipeForm) return false;
      if (kantorIpska?.isNotEmpty == true && (it.form?.kantorIpska ?? '') != kantorIpska) return false;
      if (negaraImportir?.isNotEmpty == true && (it.importir?.negaraImportir ?? '') != negaraImportir) return false;
      if (jenisTransportasi?.isNotEmpty == true && (it.importir?.jenisTransportasi ?? '') != jenisTransportasi) return false;

      return true;
    }).toList();
  }
}