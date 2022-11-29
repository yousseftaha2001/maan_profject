import 'dart:io';
import 'dart:typed_data';


import 'package:dio/dio.dart';
import 'package:test_speak/util/apis.dart';


class DioHelper {
  static late Dio dio;
  //  var token = MyDataBase.getToken();
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: base,
        responseType: ResponseType.json,
      ),
    );
  }

  // static Future<Response> getMethod({required String path}) async {
  //   try {
  //     var token = MyDataBase.getToken();
  //     // print(token);
  //     Response response = await dio.get(
  //       path,
  //       options: Options(
  //         headers: {"Authorization": "Bearer $token"},
  //       ),
  //     );
  //     // print(response);
  //     return response;
  //   } on DioError catch (e) {
  //     return e.response!;
  //   }
  // }

  // static Future<Response> postGroupToCup({
  //   required String path,
  //   required Uint8List file,
  //   String? id,
  //   String? idT,
  //   required String keyI,
  // }) async {
  //   var token = MyDataBase.getToken();
  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromBytes(file, filename: 'lea'),
  //     keyI: id,
  //   });
  //   Response response = await dio.post(
  //     path,
  //     data: formData,
  //     options: Options(
  //       headers: {"Authorization": "Bearer $token"},
  //     ),
  //   );
  //   print(response);
  //   return response;
  // }

  // static Future<Response> postCooment({
  //   required String path,
  //   required String id,
  //   required Uint8List file,
  // }) async {
  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromBytes(file, filename: 'lea.mp3'),
  //     // keyI: id,
  //     'type': '1',
  //     'id_l': id,
  //   });
  //   var token = MyDataBase.getToken();
  //   Response response = await dio.post(
  //     path,
  //     data: formData,
  //     options: Options(
  //       headers: {"Authorization": "Bearer $token"},
  //     ),
  //   );
  //   print(response);
  //   return response;
  // }

  //cup_id
  //id_cup

  // static Future<Response> postMethodWithFile(
  //     {required String path,
  //     required Uint8List file,
  //     String? id,
  //     String? idT}) async {
  //   // String fileName = file.path.split('/').last;
  //   var token = MyDataBase.getToken();
  //   if (id == null) {
  //     FormData formData = FormData.fromMap({
  //       "file": await MultipartFile.fromBytes(file, filename: 'lea'),
  //     });
  //     Response response = await dio.post(
  //       path,
  //       data: formData,
  //       options: Options(
  //         headers: {"Authorization": "Bearer $token"},
  //       ),
  //     );
  //     return response;
  //   } else {
  //     FormData formData = FormData.fromMap(idT == null
  //         ? {
  //             "file": await MultipartFile.fromBytes(file, filename: 'lea'),
  //             "id_team": id,
  //           }
  //         : {
  //             "file": await MultipartFile.fromBytes(file, filename: 'lea'),
  //             "id_league": id,
  //           });
  //     print('object');
  //     Response response = await dio.post(
  //       path,
  //       data: formData,
  //       options: Options(
  //         headers: {"Authorization": "Bearer $token"},
  //       ),
  //     );
  //     print(response.statusMessage.toString() + 'd');
  //     return response;
  //   }
  // }

  static Future< Response> postMethod(
      {required String url, required dynamic data}) async {
    try {
    
      Response response = await dio.post(
        url,
        data: FormData.fromMap(data),
        
      );
     return response;
    } on DioError catch (e) {
      // Handle error
      return e.response!;
    }
  }
}
