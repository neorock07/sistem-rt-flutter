import "dart:developer";
import "dart:io";
import "package:get/get.dart";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart";
import "package:path_provider/path_provider.dart";
import "package:permission_handler/permission_handler.dart";
import "package:sistem_rt/Activity/ResultScan.dart";

class AddNewKeluarga extends StatefulWidget {
  const AddNewKeluarga({Key? key}) : super(key: key);

  @override
  _AddNewKeluargaState createState() => _AddNewKeluargaState();
}

class _AddNewKeluargaState extends State<AddNewKeluarga> {
  CameraController? _camController;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  var condition = true.obs;

  Future<void> initCamera() async {
    var cameras = await availableCameras();
    _camController = CameraController(cameras[0], ResolutionPreset.medium);
    await _camController!.initialize();
  }

  @override
  void dispose() {
    _camController!.dispose();
    super.dispose();
  }

  Future<String> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String dir = "${root.path}/KTP_SCAN";
    await Directory(dir).create(recursive: true);
    String filePath = "${dir}/${DateTime.now()}.jpg";
    try {
      XFile? pic = await _camController!.takePicture();
      pic.saveTo(filePath);
    } catch (e) {
      log("Error : ${e.toString()}");
    }
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 234, 234, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(234, 234, 234, 1),
        title: const Text(
          "Tambah data keluarga",
          style: TextStyle(color: Colors.black, fontFamily: "Rubik"),
        ),
      ),
      body: FutureBuilder(
          future: initCamera(),
          builder: (_, snapshot) => (snapshot.connectionState ==
                  ConnectionState.done)
              ? (condition == true)? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text(
                          "Scan foto KTP",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Rubik",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.6 /
                                _camController!.value.aspectRatio,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: CameraPreview(_camController!),
                          ),
                        ),
                        Positioned(
                          top: -120.h,
                          left: 19.w,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Image.asset("assets/image/ktp_border.png"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.orange,
                          ),
                          Text(
                            "Tempatkan KTP pada area yang tersedia!",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Rubik",
                                fontSize: 15.sp),
                          )
                        ],
                      ),
                    )
                  ],
                ) : const CircularProgressIndicator()
              : const Center(child: CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_camController!.value.isTakingPicture) {
            String result = await takePicture();
            log("$result");
            final file = File(result);
            final inputImage = InputImage.fromFile(file);
            final teks = await textRecognizer.processImage(inputImage);
            List<String> fg = teks.text.toString().split("\n").toList();
            // ignore: use_build_context_synchronously
            log("${fg.length}");
            condition.value = false;
            if (fg.length > 1) {
              condition.value = true;
              // ignore: use_build_context_synchronously
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ResultScan(
                            text: fg,
                          ))));
            } else {
              // condition = true;
              const AlertDialog(
                icon: Icon(Icons.warning_amber),
                title: Text(
                  "Kesalahan format, pastikan foto adalah KTP",
                  style: TextStyle(color: Colors.black, fontFamily: "Rubik"),
                ),
              );
            }
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.h)),
        splashColor: Color.fromRGBO(194, 216, 252, 1),
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
