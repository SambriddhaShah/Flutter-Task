// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lipstick/Service/apiUrl.dart';
import 'package:lipstick/constants/errors.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = ApiUrls.baseUrl;

    // Adding interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Check network connectivity before making the request
        if (await _hasNetworkConnection()) {
          return handler.next(options); // Proceed with the request
        } else {
          return handler.reject(
            DioException(
              requestOptions: options,
              error: const NoInternetFailure('No internet connection'),
            ),
          );
        }
      },
      onResponse: (response, handler) {
        // Handle successful response
        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        // Handle different types of failures
        if (error.type == DioExceptionType.connectionTimeout) {
          return handler.reject(DioException(
              requestOptions: error.requestOptions,
              error: const NetworkFailure('Connection Timeout')));
        } else if (error.response?.statusCode == 400) {
          return handler.reject(DioException(
              requestOptions: error.requestOptions,
              error: const BadRequestFailure('Bad Request')));
        } else if (error.response?.statusCode == 500) {
          return handler.reject(DioException(
              requestOptions: error.requestOptions,
              error: const ServerFailure('Internal Server Error')));
        }
        return handler
            .next(error); // Let the error propagate if it's not handled
      },
    ));
  }

  Future<Response> productDetails() async {
    try {
      return await _dio.get(ApiUrls.peoductDetails);
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(url, queryParameters: queryParameters);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> _hasNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
