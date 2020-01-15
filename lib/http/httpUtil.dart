import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:unicom_flutter/http/api.dart';
import 'package:unicom_flutter/routes/application.dart';
import 'package:unicom_flutter/utils/index.dart';

class HttpUtil {
  static Dio dio;
  static BaseOptions options;
  static Response response;
  static String baseUrl = 'http://47.98.151.177';

  static Future request(context, path, {data, isFormData = false}) async {
    // hive
    var box = await Utils.unicomBox();

    // dio options 配置
    options = BaseOptions(
        baseUrl: baseUrl, // 拼接在url前面的
        contentType: isFormData
            ? Headers.formUrlEncodedContentType
            : Headers.jsonContentType, // 数据类型
        receiveTimeout: 10000,
        connectTimeout: 10000,
        headers: {'token': box.get('token')}); // header 添加 token

    dio = Dio(options);

    // dio 拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // 检测网络状态
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw 'noNetwork';
      }
      return options;
    }, onResponse: (Response response) async {
      // 在返回响应数据之前做一些预处理
      return response;
    }, onError: (DioError e) async {
      // 当请求失败时做一些预处理
      return e;
    }));

    // 开启请求日志
    dio.interceptors.add(LogInterceptor(responseBody: true));
    if (Platform.isIOS) {
      // 开启代理 本地连接
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY localhost:7001";
        };
      };
    }

    try {
      var params = data;
      if (isFormData) {
        FormData formData = FormData.fromMap(data);
        params = formData;
      }
      print('请求参数===============> $params');
      response = await dio.request(apiConfig[path]['url'],
          data: params, options: Options(method: apiConfig[path]['method']));
      if (response.data != null || response.data['ret'] == 0) {
        return response.data['data'] ?? '';
      } else {
        BotToast.showText(text: response.data['des'] ?? '服务器错误');
      }
    } on DioError catch (e) {
      formatError(e, box, context);
    }
  }

  // error统一处理
  static formatError(DioError e, box, context) {
    if (e.response.statusCode == 401) {
      box.delete('token');
      Application.router.navigateTo(context, '/login', clearStack: true);
      BotToast.showText(text: '登录失效，请重新登录');
    } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      BotToast.showText(text: '连接超时');
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      BotToast.showText(text: '请求超时');
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      BotToast.showText(text: '响应超时');
    } else if (e.type == DioErrorType.RESPONSE) {
      BotToast.showText(text: '出现异常');
    } else if (e.type == DioErrorType.CANCEL) {
      BotToast.showText(text: '请求取消');
    } else {
      BotToast.showText(text: e.message == 'noNetwork' ? '请检查网络连接！' : '发生未知错误');
    }
  }
}
