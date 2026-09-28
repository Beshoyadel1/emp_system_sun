import 'package:dio/dio.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:flutter/foundation.dart';
import '../../constants.dart';

class Network {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrlApi,
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
    Map<String, dynamic>? query = jsonQuery is Map<String, dynamic>
        ? Map<String, dynamic>.from(jsonQuery)
        : (jsonQuery is Map ? Map<String, dynamic>.from(jsonQuery) : null);
    dynamic effectiveData = jsonData;

    if (kIsWeb) {
      if (jsonData is Map && jsonData.isNotEmpty) {
        query ??= <String, dynamic>{};
        jsonData.forEach((key, value) {
          query![key.toString()] = value;
        });
      }
      effectiveData = null;
    } else if (jsonData is Map && jsonData.isEmpty) {
      effectiveData = null;
    }

    return await dio.get(
      url,
      data: effectiveData,
      options: Options(headers: myHeaders),
      queryParameters: query ?? jsonQuery,
    );
  }

  static Future<Response> getDataWithBody(var jsonData, String url) async {
    Map<String, dynamic>? query;
    dynamic effectiveData = jsonData;

    if (kIsWeb) {
      if (jsonData is Map && jsonData.isNotEmpty) {
        query = <String, dynamic>{};
        jsonData.forEach((key, value) {
          query![key.toString()] = value;
        });
      }
      effectiveData = null;
    } else if (jsonData is Map && jsonData.isEmpty) {
      effectiveData = null;
    }

    return await dio.get(
      url,
      data: effectiveData,
      options: Options(headers: myHeaders),
      queryParameters: query,
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
