
import 'package:dio/dio.dart';
import 'config.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);
  final Dio dio = Dio(baseOptions);


  Future<T> request<T>(String url, {data, String method = "get", Map<String, dynamic> params, Interceptor inter}) async{
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
        return response;
      },
      // 错误拦截
      onError: (error) {
        print('错误拦截');
        print(error.response.data);
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
      Response response = await dio.request(url, queryParameters: params, options: options, data: data);
      return response.data;
    } on DioError catch(e) {
      print("这里错误了");
      return Future.error(e);
    }
  }
}