
import 'package:dio/dio.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'config.dart';

class DYXHttpRequest {
  static final BaseOptions baseOptions = BaseOptions(baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);
  final Dio dio = Dio(baseOptions);


  Future<T> request<T>(String url, {
    data, // 数据源
    String method = "get", // 提交方法
    Map<String, dynamic> params, // 另外一种数据
    Interceptor inter, // 自定义拦截器
    Map<String, dynamic> headers, // 另外一种数据，比如token
    bool showSuccessMessage = true, // 展示成功的message
    bool showErrorMessage = true, // 展示失败的message
    bool showSuccessCode200Message = true, // 展示成功请求的200code信息
  }) async{
    print('url=$url');

    // 创建单独配置
    final options = Options(method: method);

    // 全局的拦截器
    // 创建默认的全局拦截器
    Interceptor dInter = InterceptorsWrapper(
      // 请求拦截
      onRequest: (options) {
        print('请求拦截');
        print(options.baseUrl);
        print(options.path);
        print('传过去的数据是${options.data}');
        return options;
      },
      // 响应拦截
      onResponse: (response) {
        print('响应拦截');
        if (!showSuccessMessage) return response;
        final message = response.data['message'];
        if (message != null) {
          if(response.data['code'] == 200 && showSuccessCode200Message || response.data['code'] != 200) {
            DYXToast.showToast(message);
          }
        }
        return response;
      },
      // 错误拦截
      onError: (error) {
        print('错误拦截');
        print(error?.response?.data);
        final message = error?.response?.data['message'];
        print(message);
        if (message != null && showErrorMessage) {
          DYXToast.showToast(message);
        }
        print(error);
        return error;
      }
    );

    List<Interceptor> inters = [dInter];

    // 自定义的拦截器
    if(inter != null) {
      inters.add(inter);
    }

    dio.interceptors.addAll(inters);

    // 发送网络请求
    try {
      // 添加响应头
      if (headers != null)
        dio.options.headers = headers;
      Response response = await dio.request(url, queryParameters: params, options: options, data: data);
      return response.data;
    } on DioError catch(e) {
      print("这里错误了");
      return Future.error(e);
    }
  }
}