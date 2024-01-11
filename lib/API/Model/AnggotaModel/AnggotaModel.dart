class AnggotaModel {
    String? id;
    String? nama;
    String? no_telp;
    dynamic tgl_lahir;
    String? tempat_lahir;
    String? jenis_kelamin;
    String? isKawin;
    String? pekerjaan;
    String? bangsa;
    String? negara;
    String? prov;
    String? kota;
    String? kecamatan;
    String? alamat;

    AnggotaModel({
      this.id, 
      this.nama, 
      this.no_telp, 
      this.tgl_lahir,
      this.tempat_lahir, 
      this.isKawin, 
      this.jenis_kelamin, 
      this.pekerjaan, 
      this.bangsa, 
      this.negara, 
      this.prov, 
      this.kota, 
      this.kecamatan,
      this.alamat
    });

    factory AnggotaModel.fromJson(Map<String, dynamic> json){
      return AnggotaModel(
        id: json["id"],
        nama: json['nama'],
        no_telp: json['no_telp'],
        tgl_lahir: json['tgl_lahir'],
        tempat_lahir: json['tempat_lahir'],
        jenis_kelamin: json['jenis_kelamin'],
        pekerjaan: json['pekerjaan'],
        isKawin: json['status_kawin'],
        bangsa: json['bangsa'],
        negara: json['negara'],
        prov: json['prov'],
        kota: json['kota'],
        kecamatan: json['kecamatan'],
        alamat: json['alamat']
      );
    }

}