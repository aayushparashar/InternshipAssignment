import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intern_assignment/Constants/Endpoints.dart';

class UploadPicture {
  static Future<bool> uploadProfilePicture(File file) async {
    var formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});
    var response = await Dio().post(
      Endpoints.uploadPictureUrl,
      data: formData,
    );
    return response.statusCode==200;
  }
}
