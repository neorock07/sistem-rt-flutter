class ProvinsiModel{

  String? id;
  String? text;
  // List<Map<String, dynamic>>? result;

  ProvinsiModel({
    this.id, 
    this.text
  });

  factory ProvinsiModel.fromJson(Map<String, dynamic>? model){
    return ProvinsiModel(
        id: model!['id'],
        text: model['text']
    );
  }


}


// "status": 200,
//     "message": "Berhasil",
//     "result": [

//       "id": "1",
//       "text": "Bali"
//     ]