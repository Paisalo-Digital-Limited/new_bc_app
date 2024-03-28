
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import '../model/fiservice_bannerdatamodel.dart';

part 'fiservice_apiservice.g.dart';

@RestApi(baseUrl: "https://erpservice.paisalo.in:980/PDL.FIService.API/api/")
abstract class FiService_ApiService{
  factory FiService_ApiService(Dio dio,{String baseUrl}) = _FiService_ApiService;


  static FiService_ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger( requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return FiService_ApiService(dio);
  }

  @GET("Notification/GetBannerPostingMobile")
  Future<FiServiceBannerDataModel> getBannerFromFiService(@Query("AppType") String AppType);



}