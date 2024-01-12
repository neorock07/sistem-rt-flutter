class KategoriModel{
  String? id;
  String? name;
  List<int>? keuangan;

  KategoriModel({
    this.id, 
    this.name,
    this.keuangan
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json){
    return KategoriModel(
      id: json['id'],
      name: json['name'],
      keuangan: json['keuangan'],
    );
  }


}