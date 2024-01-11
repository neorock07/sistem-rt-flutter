import "dart:developer";

import "package:anim_search_bar/anim_search_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:sistem_rt/API/Model/AnggotaModel/AnggotaModel.dart";
import "package:sistem_rt/Activity/AddManual.dart";
import "package:sistem_rt/Activity/AddNewKeluarga.dart";
import "package:sistem_rt/Activity/DetailKeluarga.dart";
import "package:sistem_rt/Controller/AnggotaController/DetailKeluargaController.dart";
import "package:sistem_rt/Controller/KepalaKKController/KepalaController.dart";
import "package:sistem_rt/Controller/LoginController/PrefController.dart";
import "package:sistem_rt/Controller/SearchController/SearchController.dart";

import "../API/Model/KepalaKelModel/AdminModel.dart";

// import "Partials/CardBtm.dart";

class KeluargaView extends StatefulWidget {
  const KeluargaView({Key? key}) : super(key: key);

  @override
  _KeluargaViewState createState() => _KeluargaViewState();
}

class _KeluargaViewState extends State<KeluargaView> {
  var controller = TextEditingController();

  var kepalaController = Get.put(KepalaController());
  var prefController = Get.put(PrefController());
  var token;
  var data;
  List<AdminModel?>? list_kk;
  List<AdminModel?>? list_kk_new;
  var bongkar = Get.put(BongkarController());
  var detailController = Get.put(DetailKeluargaController());

  Future<void> shared() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // token = pref.getString("token");
    kepalaController.getAll().then((value) {
      list_kk = value;
      setState(() {});
    });
    if(kepalaController.raValid == true){
      Navigator.pop(context);
    }
    // return list_kk!;
  }

  @override
  void initState() {
    super.initState();
    shared();
    
    // list_kk = kepalaController.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(234, 234, 234, 1),
        body: (list_kk != null)
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 80.h,
                    pinned: true,
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
                    title: const Text(
                      "Data Keluarga",
                      style:
                          TextStyle(fontFamily: "Rubik", color: Colors.white),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: AnimSearchBar(
                          width: MediaQuery.of(context).size.width * 0.7,
                          textController: controller,
                          onSuffixTap: () {},
                          onSubmitted: (String st) {
                           list_kk_new =  bongkar.Bongkar(st, list_kk!.cast<AdminModel>());
                           log("list_kk : ${list_kk!.length} \n list_kk_new : ${list_kk_new!.length}"); 
                           if(list_kk_new!.length == 0){
                              showDialog(
                                context: context,
                                builder: (snap){
                                  return const AlertDialog(
                                    title: Text("Ooops!..."),
                                    actions: [
                                      Center(
                                        child: Text("Sayangnya nggak ada datanya😢"),
                                      )
                                    ],
                                  );
                                }
                                );  
                           }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Text(
                                            "Pilih metode pengisian data : ",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontFamily: "Rubik",
                                                fontSize: 16.sp),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          cardBtm(context,
                                              label: "Scan e-Ktp",
                                              color: Colors.black,
                                              goto: const AddNewKeluarga()),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          cardBtm(context,
                                              label: "Tambah Manual",
                                              color: Colors.black,
                                              goto: const AddManual()),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.h)),
                                fixedSize: Size(30.w, 30.h)),
                            child: const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ))),
                      ),
                    ],
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (list_kk!.isNotEmpty)
                          ? CardKK(context,
                              kk:  (list_kk_new != null )? list_kk_new![index]!.id  : list_kk![index]!.id,
                              name: (list_kk_new != null)? list_kk_new![index]!.username :list_kk![index]!.username)
                          : const CircularProgressIndicator(),
                    );
                  }, childCount: (list_kk != null) ? (list_kk_new != null)? list_kk_new!.length : list_kk!.length : 0))
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }

  Widget CardKK(BuildContext context, {String? kk, String? name}) {
    double? p;
    return InkWell(
      onTap: () async {
        p = 8.h;
        // Map<String, dynamic> model;
        FutureBuilder(
          future: detailController.findById(id: kk).then((value) => data),
          builder: (_, snap){
            if(snap.connectionState == ConnectionState.waiting){
              
              // Get.snackbar("data", data.runtimeType.toString());
            }
            data = snap.data;
            print(data.toString());
            return Text("");
          });
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailKeluarga(kk: kk,)));

      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h), color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all((p != null)? p : 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "#No.KK : $kk",
                    style: const TextStyle(color: Colors.grey, fontFamily: "Rubik"),
                  )),
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_3,
                          color: Color.fromRGBO(23, 78, 171, 1.0),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "$name",
                          style: TextStyle(
                              fontFamily: "Helvetica",
                              color: Colors.black,
                              fontSize: 18.sp),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardBtm(BuildContext context,
      {String? label, Color? color, dynamic goto}) {
    return InkWell(
      onTap: () {
        // Get.to(() => goto);
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => goto)));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          // width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              // color: color,
              borderRadius: BorderRadius.circular(10.h),
              border: Border.all(
                color: color!,
              )),
          child: Center(
            child: Text(
              "$label",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Rubik", fontSize: 18.sp),
            ),
          ),
        ),
      ),
    );
  }
}


