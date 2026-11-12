import 'package:dio/dio.dart';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:flutter/foundation.dart';
import '../../constants.dart';

class Network {
  static String _languageCode = 'ar';

  static String get languageCode => _languageCode;

  static void setLanguageCode(String languageCode) {
    _languageCode = languageCode.toLowerCase() == 'en' ? 'en' : 'ar';
  }

  static final Dio dio = _createDio();

  static Dio _createDio() {
    final client = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrlApi,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Remove a language embedded in the URL before adding the current one.
          final uri = Uri.parse(options.path);
          if (uri.queryParameters.containsKey('lang')) {
            final query = Map<String, List<String>>.from(uri.queryParametersAll)
              ..remove('lang');
            options.path = query.isEmpty
                ? uri.replace(query: '').toString()
                : uri.replace(queryParameters: query).toString();
          }
          options.queryParameters = {
            ...options.queryParameters,
            'lang': _languageCode,
          };
          handler.next(options);
        },
      ),
    );
    return client;
  }

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

  static Future<Response> putDataWithBodyAndParams(
      var jsonData, var jsonQuery, String url) async {
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

  static Future<Response> deleteDataWithBodyAndParams(
      var jsonData, var jsonQuery, String url) async {
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

  static Future<Response> postDataWithBodyAndParams(
      var jsonData, var jsonQuery, String url) async {
    return await dio.post(
      url,
      data: jsonData,
      queryParameters: jsonQuery,
      options: Options(headers: myHeaders),
    );
  }
}
