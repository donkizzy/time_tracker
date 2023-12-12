import 'package:dio/dio.dart';
import 'package:time_tracker/core/network/api_error.dart';
import 'package:time_tracker/core/network/app_interceptor.dart';


class NetworkProvider{

  Dio _getDioInstance(){
    var dio=Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
    ));

    dio.interceptors.add(AppInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true,error: true,request: true,requestBody: true));

    return dio;
  }

  Future<Response?> call(
      {
        required String path,
        required  RequestMethod method,
        Map<String,dynamic> body=const {},
        Map<String,dynamic> queryParams=const {}
      })async{
    Response? response;
    try{

      switch(method){
        case RequestMethod.get:
          response = await _getDioInstance().get(path, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          response = await _getDioInstance()
              .post(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.patch:
          response = await _getDioInstance()
              .patch(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.put:
          response = await _getDioInstance()
              .put(path, data: body, queryParameters: queryParams);
          break;
        case RequestMethod.delete:
          response = await _getDioInstance()
              .delete(path, data: body, queryParameters: queryParams);
          break;


      }

      return response;
    }on DioException catch (e) {
      return Future.error(ApiError.fromDio(e));
    }

  }
}

enum RequestMethod { get, post, put, patch, delete }