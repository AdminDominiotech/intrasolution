// Dart imports:
import 'dart:convert' show base64Encode, base64Decode;
import 'dart:io';
// import 'dart:math';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static Future<String?> xFileToBase64(XFile image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final baseimage = base64Encode(imageBytes);
      return baseimage;
    } catch (e) {
      debugPrint('ERROR EN CONVERSION DE IMAGEN A BASE 64:  $e');
      return null;
    }
  }

  static Future<String?> fileToBase64(File image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final baseimage = base64Encode(imageBytes);
      return baseimage;
    } catch (e) {
      debugPrint('ERROR EN CONVERSION DE IMAGEN A BASE 64:  $e');
      return null;
    }
  }

  static Future<File?> stringBase64ToFile(
      {required String image, String? name}) async {
    try {
      final decodedBytes = base64Decode(image);

      final directory = await getTemporaryDirectory();
      final basePath = directory.path;

      await Directory('$basePath/evidence').create(recursive: true);

      String path;

      if (name == null) {
        path =
            '$basePath/evidence/${DateFormat('yyyyMMddHms.SSS').format(DateTime.now())}.jpg';
      } else {
        path = '$basePath/evidence/$name.jpg';
      }

      File file = await File(path).writeAsBytes(decodedBytes);
      // await File(path).delete();
      return file;
    } catch (e) {
      debugPrint('ERROR EN CONVERSION DE String A FILE:  $e');
      return null;
    }
  }

  static Future<File?> compressImage(File file) async {
    final reImage = decodeImage(file.readAsBytesSync());

    final directory = await getTemporaryDirectory();
    final basePath = directory.path;
    dynamic outPath;
    dynamic path;
    dynamic filename;
    await Directory('$basePath/evidence').create(recursive: true);

    filename =
        '${DateFormat('yyyyMMddHms.SSS').format(DateTime.now())}-min.jpg';

    path =
        '$basePath/evidence/${DateFormat('yyyyMMddHms').format(DateTime.now())}.jpg';

    outPath = '$basePath/evidence/$filename';

    File(path).writeAsBytesSync(encodeJpg(reImage!));

    final newFile = await FlutterImageCompress.compressAndGetFile(
      path,
      outPath,
      quality: 50,
    );

    await File(path).delete();

    return newFile;
  }

  // static String randomID({int max = 10}) {
  //   var abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0abcdefghijklmnopqrstuvwxyz123456789';

  //   var letters = abc.split('');

  //   var min = 0;
  //   var char = '';
  //   for (var i = 0; i < max; i++) {
  //     var rn = Random();
  //     var numberRn = min + rn.nextInt(letters.length - min);

  //     var charTemp = letters[numberRn];
  //     char += charTemp;
  //   }

  //   return char;
  // }

  static String currentTime() {
    final now = DateTime.now();

    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  static String convertSecondsToMinutes(int seconds) {
    final minutes = seconds ~/ 60;
    final newSeconds = seconds % 60;

    return '$minutes:${newSeconds.toString().padLeft(2, '0')}';
  }

  static String convertDateTimeToString(DateTime dt,
      {bool isComplete = false}) {
    final defaultDate = DateTime.now();
    if (isComplete) {
      return '${dt.year.toString().padLeft(2, '0')}-'
          '${dt.month.toString().padLeft(2, '0')}-'
          '${dt.day.toString().padLeft(2, '0')}'
          ' ${defaultDate.hour.toString().padLeft(2, '0')}:'
          '${defaultDate.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.year.toString().padLeft(2, '0')}-'
        '${dt.month.toString().padLeft(2, '0')}-'
        '${dt.day.toString().padLeft(2, '0')}';
  }

  static String currentDateTimeHourToString() {
    final defaultDate = DateTime.now();
    return '${defaultDate.hour.toString().padLeft(2, '0')}:'
        '${defaultDate.minute.toString().padLeft(2, '0')}:'
        '${defaultDate.second.toString().padLeft(2, '0')}';
  }

  // static Color fromHex(String hexString) {
  //   final buffer = StringBuffer();
  //   if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  //   buffer.write(hexString.replaceFirst('#', ''));
  //   return Color(int.parse(buffer.toString(), radix: 16));
  // }

  // TODO: PARA CESAR
  static int daysDifference() {
//      final birthday = DateTime(2022, 01, 28);
//  final date2 = DateTime.now();
//  final difference = date2.difference(birthday).inDays;
    return 0;
  }

  static String splitDescription(String description) {
    final list = description.split('');
    var i = 0;
    var text = '';
    for (final letter in list) {
      if (i == 31) {
        i = 0;
        text += '\n';
      }
      text += letter;
      i++;
    }
    return text;
  }
}
