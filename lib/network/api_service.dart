import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_bc_app/model/CspMonthlyLazerResponse.dart';
import 'package:new_bc_app/model/commissionDetailsResponse.dart';
import 'package:new_bc_app/model/getTaskSlabDetailsResponse.dart';
import 'package:new_bc_app/model/leaderBoardDataResponse.dart';
import 'package:new_bc_app/model/monthlyTaskStatus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../model/CspWeeklyLazerResponse.dart';
import '../model/TransactionDetailsByCodeModel.dart';
import '../model/annualcspreport.dart';
import '../model/bannerurlmodel.dart';
import '../model/cSPKYCDocumentModel.dart';
import '../model/commonresponsemodel.dart';
import '../model/commonresponsemodelInt.dart';
import '../model/getCSPAppTransactionDetails.dart';
import '../model/gettargetmodel.dart';
import '../model/loginresponse.dart';
import '../model/servicelistmodel.dart';
import '../model/slablistmodel.dart';
import '../model/transhistoryresponse.dart';
import '../model/withdrawalanddepsitmodel.dart';

part 'api_service.g.dart';
//1A999096
// @RestApi(baseUrl: "https://erpservice.paisalo.in:980/PDL.BC.Api/api/")
@RestApi(baseUrl: "https://bc.paisalo.in:987/api/")
abstract class ApiService{
  factory ApiService(Dio dio,{String baseUrl}) = _ApiService;


  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger( requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return ApiService(dio);
  }


  @POST("User/GetToken")
  Future<LoginResponse> getLogins(@Field("EmailId") String email,@Field("Password") String password);


  @POST("BCTransaction/InsertMonthTargetCSP")
  Future<CommonResponseModel> setTarget(@Header("Authorization") String bearerToken,@Field("CspCode") String cspCode,@Field("TargetCommAmount") String targetCommAmount,@Field("Month") String month,@Field("Year") String year);



  @GET("BCTransaction/CSPMothlyTarget")
  Future<GetTargetModel> getTarget(@Query("KO_ID") String KO_ID,@Query("Month") String Month,@Query("Year") String Year);


  @GET("BCTransaction/GetBcTransactions")
  Future<TransHistoryResponse> getTransHistory(@Query("CspCode") String cspCode,@Query("fromdate") String fromdate,@Query("todate") String todate);


  @POST("BCTransaction/UpdateGSMId")
  Future<CommonResponseModelInt> updateGsmid(@Header("Authorization") String bearerToken,
      @Field("KO_Id") String cspCode,@Field("GSMId") String gsmid);

  @POST("BCWithdrawl/InsertWithdrawlRequests")
  Future<CommonResponseModelInt> uploadWithDrawalData(@Header("Authorization") String bearerToken,@Field("cspCode") String cspCode,@Field("amount") String amount,@Field("reqType") String reqType,@Field("isApproved") String isApproved,@Field("approvedBy") String approvedBy);

  @POST("BCWithdrawl/InsertWithdrawlRequestsReceipt")
  @MultiPart()
  Future<CommonResponseModel> uploadDepositeData(@Part(name: "CspName") String CspName,@Part(name: "CspCode") String cspCode,@Part(name: "Amount") String amount,@Part(name: "ReqType") String reqType,@Part(name: "IsApproved") String isApproved,@Part(name: "ApprovedBy") String approvedBy,  @Part(name: "Receipt") File file);


  @GET("BCWithdrawl/GetWithdrawlRequests")
  Future<WithdrawalAndDepsitModel> getWithdrawalAndDepositHistory( @Header("Authorization") String bearerToken ,@Query("CspCode") String CspCode);



  @GET("BCTransaction/GetAllSlabDetails")
  Future<SlabListModel> getAllSlabList();



  @GET("BCWithdrawl/GetBannerPosting")
  Future<BannerDataModel> getBannerImageUrl(@Query("AppType") String AppType);


  @GET("BCTransaction/GetCSPAppCommission")
  Future<ServiceListModel> getServiceList();



  @GET("BCTransaction/GetMonthlyCommissionDetails")
  Future<CspAnnualReport> getCSPAnnualReport(@Query("CspCode") String cspCode,@Query("month") String month,@Query("year") String year);



  @GET("BCTransaction/GetTopCommissions")
  Future<LeaderBoardDataResponse> getLeaderBoardData();


  @GET("BCTransaction/GetCommissionCount")
  Future<CommisionDetailsResponse> getCommsionDetails(@Query("fromDate") String fromdate,@Query("todate") String todate,@Query("koId") String koId,@Query("areaType") String areaType,@Query("isLive") String isLive);



  @GET("BCTransaction/GetTaskSlabDetails")
  Future<GetTaskSlabDetailsResponse> getTaskSlabDetails();

  @POST("BCTransaction/InsertCspKycDocument")
  @MultiPart()
  Future<CommonResponseModel> insertCspKycDocument(
      @Part(name:'CspId') String cspId,
      @Part(name:'DocType') String docType,
      @Part(name:'IsDelete') bool isDelete,
      @Part(name: "file") File file);

  @GET("BCTransaction/GetWeeklyCommission")
  Future<CspWeeklyLazerResponse> getCSPWeeklyCommision(@Query("KOId") String kOId);



  @GET("BCTransaction/GetCspMonthlyLazer")
  Future<CspMonthlyLazerResponse> getCSPMonthlyCommision(@Query("cspcode") String kOId);


  @GET("BCTransaction/GetTargetStatus")
  Future<MonthlyTaskStatus> getTargetStatus(@Query("koid") String kOId,@Query("Month") String month,@Query("Year") String year);


  @GET("BCTransaction/GetCSPKYCdocument")
  Future<CspkycDocumentModel> getCSPKYCdocument(@Query("CspId") String CspId );

  @GET("BCTransaction/GetCSPAppTransactionDetails")
  Future<GetCspAppTransactionDetails> getCspAppTransactionDetails();

  @GET("BCTransaction/GetTransactionDetailsByCode")
  Future<TransactionDetailsByCodeModel> getTransactionDetailsByCodeModel(@Query("cspcode") String kOId,@Query("month") String month,@Query("year") String year);

  @POST("User/BcuserInsertTracking")
  Future<CommonResponseModel> getBcUserInsertTracking(@Query("cspcode") String cspcode,@Query("activity") String activity,@Query("latitude") String latitude,@Query("longitude") String longitude);

}







