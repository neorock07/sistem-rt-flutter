class KeuanganModel{
  int? id;
  int? nominal;
  dynamic? date;

  KeuanganModel({
      this.id, 
      this.nominal,
      this.date
  });

  factory KeuanganModel.fromJson(Map<String, dynamic> json){
    return KeuanganModel(
      id: json['id'],
      nominal: json['nominal'],
      date: json['date']
    );
  }
}