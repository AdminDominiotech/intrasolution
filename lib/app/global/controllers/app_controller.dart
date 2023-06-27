// Dart imports:
import 'dart:io';

// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:safe2biz/app/global/core/errors/exceptions.dart';
import 'package:safe2biz/app/global/core/utils/utils.dart';
import 'package:safe2biz/app_infraestructure/device_info/device_info.dart';

// Project imports:
enum TypeSource { camera, gallery }

class AppController {
  // -------------------VARIABLES-------------------
  static int? _platformInt;
  static String? _modelDevice;
  static String? _versionApp;

  // -------------------------------------------------------
  // -------------------IMAGEN PICKER-------------------
  Future<File?> loadImageDevice(TypeSource typeSource) async {
    try {
      var _picker = ImagePicker();
      final source = typeSource == TypeSource.camera
          ? ImageSource.camera
          : ImageSource.gallery;
      final xFile = await _picker.pickImage(source: source);
      if (xFile != null) {
        final image = File(xFile.path);

        // final zipImage = await Utils.compressImage(image);
        // final newImage = zipImage ?? image;
        // final base64 = await Utils.fileToBase64(newImage);
        // final filename =
        //     '${DateFormat('yyyyMMddHms').format(DateTime.now())}-min.jpg';
        // return ImgResponse(file: newImage, base64: base64!, nameFile: filename);
        return image;
      }
    } catch (e) {
      print('😊 $e');
      // _picker.retrieveLostData();
      throw LocalException(message: e.toString());
    }
    return null;
  }

  Future<ImgResponse> transformImage(File file) async {
    try {
      final zipImage = await Utils.compressImage(file);
      final newImage = zipImage ?? file;
      final base64 = await Utils.fileToBase64(newImage);
      final filename =
          '${DateFormat('yyyyMMddHms').format(DateTime.now())}-min.jpg';
      return ImgResponse(base64: base64!, nameFile: filename);
    } catch (e) {
      throw LocalException(message: e.toString());
    }
  }

  // Future<ImgResponse?> loadImageDevice(TypeSource typeSource) async {
  //   try {
  //     var _picker = ImagePicker();
  //     final source = typeSource == TypeSource.camera
  //         ? ImageSource.camera
  //         : ImageSource.gallery;
  //     final xFile = await _picker.pickImage(source: source);
  //     if (xFile != null) {
  //       final image = File(xFile.path);

  //       final zipImage = await Utils.compressImage(image);
  //       final newImage = zipImage ?? image;
  //       final base64 = await Utils.fileToBase64(newImage);
  //       final filename =
  //           '${DateFormat('yyyyMMddHms').format(DateTime.now())}-min.jpg';
  //       return ImgResponse(file: newImage, base64: base64!, nameFile: filename);
  //     }
  //   } catch (e) {
  //     throw LocalException(message: e.toString());
  //   }
  //   return null;
  // }

  // -------------------------------------------------------
  // -------------------DEVICE INFORMATION------------------
  int get getPlatformInt => _platformInt!;
  String get getModelDevice => _modelDevice!;
  String get getVersionApp => _versionApp!;

  Future<void> loadDevice() async {
    if (_platformInt == null || _modelDevice == null || _versionApp == null) {
      final dinfo = Device.info;
      _platformInt = dinfo.getPlatformInt;
      _modelDevice = await dinfo.getModelDevice();
      _versionApp = await dinfo.getVersion();
    }
  }
}

class ImgResponse {
  const ImgResponse({
    required this.base64,
    required this.nameFile,
  });
  final String base64;
  final String nameFile;
}
