import 'package:flutter/material.dart';

enum SkaStatusType {
  all,
  verifikasi,
  requestRevisi,
  diprosesIpska,
  pengajuanCabutSka,
  ditolak,
  diterbitkan,
  pencabutan,
}

class SkaStatusStyle {
  final Color bg;
  final Color fg;
  const SkaStatusStyle(this.bg, this.fg);
}

/// Map warna status (sesuai instruksi)
const Map<SkaStatusType, SkaStatusStyle> kSkaStatusColors = {
  SkaStatusType.verifikasi:      SkaStatusStyle(Color(0xFF7E57C2), Colors.white), // ungu
  SkaStatusType.requestRevisi:   SkaStatusStyle(Color(0xFFF06292), Colors.white), // pink
  SkaStatusType.diprosesIpska:   SkaStatusStyle(Color(0xFF3F51B5), Colors.white), // indigo
  SkaStatusType.pengajuanCabutSka:SkaStatusStyle(Color(0xFFFFA000), Colors.black),// oranye
  SkaStatusType.ditolak:         SkaStatusStyle(Color(0xFF8D4B3A), Colors.white), // merah bata
  SkaStatusType.diterbitkan:     SkaStatusStyle(Color(0xFF43A047), Colors.white), // hijau
  SkaStatusType.pencabutan:      SkaStatusStyle(Color(0xFF424242), Colors.white), // abu/black
  SkaStatusType.all:             SkaStatusStyle(Colors.black12, Colors.black87),
};

SkaStatusType parseSkaStatus(String raw) {
  final s = raw.trim().toLowerCase();
  if (s == 'verifikasi') return SkaStatusType.verifikasi;
  if (s == 'request revisi') return SkaStatusType.requestRevisi;
  if (s == 'diproses ipska') return SkaStatusType.diprosesIpska;
  if (s == 'pengajuan cabut ska') return SkaStatusType.pengajuanCabutSka;
  if (s == 'ditolak') return SkaStatusType.ditolak;
  if (s == 'diterbitkan') return SkaStatusType.diterbitkan;
  if (s == 'pencabutan') return SkaStatusType.pencabutan;
  return SkaStatusType.all;
}

class SkaPengajuan {
  final String? namaPerusahaan;
  final String? namaEksportir;
  final String? noAju;
  final String? noSka;
  final String? tglKirim;
  SkaPengajuan({
    this.namaPerusahaan,
    this.namaEksportir,
    this.noAju,
    this.noSka,
    this.tglKirim,
  });
}

class SkaStatus {
  final SkaStatusType type;
  final String waktuStatus;
  final String? keterangan;
  SkaStatus({
    required this.type,
    required this.waktuStatus,
    this.keterangan,
  });
}

class SkaImportir {
  final String? namaImportir, negaraImportir, jenisTransportasi, tglRencanaEkspor;
  SkaImportir({this.namaImportir, this.negaraImportir, this.jenisTransportasi, this.tglRencanaEkspor});
}

class SkaForm {
  final String? jenisForm, tipeForm, kantorIpska, noInvoice, noDocPabean;
  SkaForm({this.jenisForm, this.tipeForm, this.kantorIpska, this.noInvoice, this.noDocPabean});
}

class SkaItem {
  final int no;
  final SkaPengajuan pengajuan;
  final SkaImportir? importir;
  final SkaForm? form;
  final SkaStatus status;
  SkaItem({required this.no, required this.pengajuan, this.importir, this.form, required this.status});
}