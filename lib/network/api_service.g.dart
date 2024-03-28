// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://erpservice.paisalo.in:980/PDL.BC.Api/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResponse> getLogins(
    String email,
    String password,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'EmailId': email,
      'Password': password,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'User/GetToken',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponseModel> setTarget(
    String bearerToken,
    String cspCode,
    String targetCommAmount,
    String month,
    String year,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'CspCode': cspCode,
      'TargetCommAmount': targetCommAmount,
      'Month': month,
      'Year': year,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/InsertMonthTargetCSP',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CommonResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetTargetModel> getTarget(
    String KO_ID,
    String Month,
    String Year,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'KO_ID': KO_ID,
      r'Month': Month,
      r'Year': Year,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GetTargetModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/CSPMothlyTarget',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetTargetModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TransHistoryResponse> getTransHistory(
    String cspCode,
    String fromdate,
    String todate,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'CspCode': cspCode,
      r'fromdate': fromdate,
      r'todate': todate,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TransHistoryResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetBcTransactions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TransHistoryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponseModel> updateGsmid(
    String bearerToken,
    String cspCode,
    String gsmid,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'KO_Id': cspCode,
      'GSMId': gsmid,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/UpdateGSMId',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CommonResponseModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponseModelInt> uploadWithDrawalData(
    String bearerToken,
    String cspCode,
    String amount,
    String reqType,
    String isApproved,
    String approvedBy,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'cspCode': cspCode,
      'amount': amount,
      'reqType': reqType,
      'isApproved': isApproved,
      'approvedBy': approvedBy,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponseModelInt>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCWithdrawl/InsertWithdrawlRequests',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CommonResponseModelInt.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WithdrawalAndDepsitModel> getWithdrawalAndDepositHistory(
    String bearerToken,
    String CspCode,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'CspCode': CspCode};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WithdrawalAndDepsitModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCWithdrawl/GetWithdrawlRequests',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = WithdrawalAndDepsitModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SlabListModel> getAllSlabList() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SlabListModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetAllSlabDetails',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SlabListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BannerDataModel> getBannerImageUrl(String AppType) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'AppType': AppType};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BannerDataModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCWithdrawl/GetBannerPosting',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BannerDataModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ServiceListModel> getServiceList() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ServiceListModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetCommissionDatabytype',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ServiceListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CspAnnualReport> getCSPAnnualReport(String cspCode) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'cspCode': cspCode};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CspAnnualReport>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'User/GetFileList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CspAnnualReport.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
