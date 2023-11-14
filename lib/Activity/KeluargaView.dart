import "package:anim_search_bar/anim_search_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class KeluargaView extends StatefulWidget {
  const KeluargaView({Key? key}) : super(key: key);

  @override
  _KeluargaViewState createState() => _KeluargaViewState();
}

class _KeluargaViewState extends State<KeluargaView> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 234, 234, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.h,
            pinned: true,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
            title: const Text(
              "Data Keluarga",
              style: TextStyle(fontFamily: "Rubik", color: Colors.white),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: AnimSearchBar(
                  width: MediaQuery.of(context).size.width * 0.7,
                  textController: controller,
                  onSuffixTap: () {},
                  onSubmitted: (String st) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: ElevatedButton(
                    onPressed: () {},
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
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardKK(context),
            );
          },
          childCount: 20
          )
          )
        ],
      ),
    );
  }

  Widget CardKK(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          color: Colors.white
          ),
      child: Padding(
        padding: EdgeInsets.all(5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("#No.KK : 334334",
               style: TextStyle(color: Colors.grey, fontFamily: "Rubik"),)),
           Padding(
             padding: EdgeInsets.all(8.0.h),
             child: Row(
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_3, color:Color.fromRGBO(23, 78, 171, 1.0) ,),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text("Sugali", style: TextStyle(fontFamily: "Helvetica", color: Colors.black, fontSize: 18.sp),)
                  ],
                ),

              ],
             ),
           )    
          ],
        ),
        ),

    );
  }
}



// AppBar(
//         toolbarHeight: 120.h,
//         backgroundColor: const Color.fromRGBO(23, 78, 171, 1.0),
//         iconTheme: const IconThemeData(
//           color: Colors.white
//         ),
//         title: const Text("Data Keluarga", style: TextStyle(fontFamily: "Rubik", color: Colors.white),),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 10.w),
//             child: ElevatedButton(
//               onPressed: (){},
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5.h)
//                 ),
//                 fixedSize: Size(30.w, 30.h)
//               ),
//               child: const Align(
//                 alignment: Alignment.center,
//                 child: Icon(Icons.add, color: Colors.black,))
//               ),
//           ),

//         ],
//         flexibleSpace: Align(
//           alignment: Alignment.bottomLeft,
//           child: Padding(
//             padding: EdgeInsets.only(left:8.w, bottom: 4.h),
//             child: Container(
//               height: 30.h,
//               width: MediaQuery.of(context).size.width * 0.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4.h),
//                 border: Border.all(
//                   color: Colors.grey
//                 )
//               ),
//               child: SearchBar(
//                 backgroundColor: MaterialStatePropertyAll(
//                   Colors.white
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),