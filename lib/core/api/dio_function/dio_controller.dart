import 'package:dio/dio.dart';
import '../../constants.dart';

class Network {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static Future<Response> getData(String url) async {
    return await dio.get(url, options: Options(headers: myHeaders));
  }

  static Future<Response> putDataWithBody(var jsonData, String url) async {
    return await dio.put(
      url,
      data: jsonData,
      options: Options(headers: myHeaders),
    );
  }

  static Future<Response> putDataWithBodyAndParams(var jsonData, var jsonQuery, String url) async {
    return await dio.put(
      url,
      data: jsonData,
      queryParameters: jsonQuery,
      options: Options(headers: myHeaders),
    );
  }
  static Future<Response> deleteData(var jsonQuery, String url) async {
    return await dio.delete(
      url,
      options: Options(headers: myHeaders),
      queryParameters: jsonQuery,
    );
  }
  static Future<Response> deleteDataWithBody(var jsonData, String url) async {
    return await dio.delete(
      url,
      data: jsonData,
      options: Options(headers: myHeaders),
    );
  }

  static Future<Response> deleteDataWithBodyAndParams(var jsonData, var jsonQuery, String url) async {
    return await dio.delete(
      url,
      data: jsonData,
      queryParameters: jsonQuery,
      options: Options(headers: myHeaders),
    );
  }
  static Future<Response> getDataWithBodyAndParams(
      var jsonData, var jsonQuery, String url) async {
    return await dio.get(
      url,
      data: jsonData,
      options: Options(headers: myHeaders),
      queryParameters: jsonQuery,
    );
  }

  static Future<Response> getDataWithBody(var jsonData, String url) async {
    return await dio.get(
      url,
      data: jsonData,
      options: Options(headers: myHeaders),
    );
  }
  static Future<Response> postDataWithBody(var jsonData, String url) async {
    return await dio.post(
      url,
      data: jsonData,
      options: Options(headers: myHeaders),
    );
  }

  static Future<Response> postDataWithBodyAndParams(var jsonData, var jsonQuery, String url) async {
    return await dio.post(
      url,
      data: jsonData,
      queryParameters: jsonQuery,
      options: Options(headers: myHeaders),
    );
  }
}
