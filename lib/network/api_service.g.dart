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
  Future<CommonResponseModelInt> updateGsmid(
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
        _setStreamType<CommonResponseModelInt>(Options(
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
    final value = CommonResponseModelInt.fromJson(_result.data!);
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
  Future<CommonResponseModel> uploadDepositeData(
    String CspName,
    String cspCode,
    String amount,
    String reqType,
    String isApproved,
    String approvedBy,
    File file,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'CspName',
      CspName,
    ));
    _data.fields.add(MapEntry(
      'CspCode',
      cspCode,
    ));
    _data.fields.add(MapEntry(
      'Amount',
      amount,
    ));
    _data.fields.add(MapEntry(
      'ReqType',
      reqType,
    ));
    _data.fields.add(MapEntry(
      'IsApproved',
      isApproved,
    ));
    _data.fields.add(MapEntry(
      'ApprovedBy',
      approvedBy,
    ));
    _data.files.add(MapEntry(
      'Receipt',
      MultipartFile.fromFileSync(
        file.path,
        filename: file.path.split(Platform.pathSeparator).last,
      ),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'BCWithdrawl/InsertWithdrawlRequestsReceipt',
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
              'BCTransaction/GetCSPAppCommission',
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
  Future<CspAnnualReport> getCSPAnnualReport(
    String cspCode,
    String month,
    String year,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'CspCode': cspCode,
      r'month': month,
      r'year': year,
    };
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
              'BCTransaction/GetMonthlyCommissionDetails',
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

  @override
  Future<LeaderBoardDataResponse> getLeaderBoardData() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LeaderBoardDataResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetTopCommissions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = LeaderBoardDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommisionDetailsResponse> getCommsionDetails(
    String fromdate,
    String todate,
    String koId,
    String areaType,
    String isLive,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'fromDate': fromdate,
      r'todate': todate,
      r'koId': koId,
      r'areaType': areaType,
      r'isLive': isLive,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommisionDetailsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetCommissionCount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CommisionDetailsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetTaskSlabDetailsResponse> getTaskSlabDetails() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetTaskSlabDetailsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetTaskSlabDetails',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetTaskSlabDetailsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResponseModel> insertCspKycDocument(
    String cspId,
    String docType,
    bool isDelete,
    File file,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'CspId',
      cspId,
    ));
    _data.fields.add(MapEntry(
      'DocType',
      docType,
    ));
    _data.fields.add(MapEntry(
      'IsDelete',
      isDelete.toString(),
    ));
    _data.files.add(MapEntry(
      'file',
      MultipartFile.fromFileSync(
        file.path,
        filename: file.path.split(Platform.pathSeparator).last,
      ),
    ));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResponseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              'BCTransaction/InsertCspKycDocument',
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
  Future<CspWeeklyLazerResponse> getCSPWeeklyCommision(String kOId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'KOId': kOId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CspWeeklyLazerResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetWeeklyCommission',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CspWeeklyLazerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CspMonthlyLazerResponse> getCSPMonthlyCommision(String kOId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'cspcode': kOId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CspMonthlyLazerResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetCspMonthlyLazer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CspMonthlyLazerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MonthlyTaskStatus> getTargetStatus(
    String kOId,
    String month,
    String year,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'koid': kOId,
      r'Month': month,
      r'Year': year,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MonthlyTaskStatus>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetTargetStatus',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = MonthlyTaskStatus.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CspkycDocumentModel> getCSPKYCdocument(String CspId) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'CspId': CspId};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CspkycDocumentModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetCSPKYCdocument',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CspkycDocumentModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCspAppTransactionDetails> getCspAppTransactionDetails() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCspAppTransactionDetails>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetCSPAppTransactionDetails',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetCspAppTransactionDetails.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TransactionDetailsByCodeModel> getTransactionDetailsByCodeModel(
    String kOId,
    String month,
    String year,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'cspcode': kOId,
      r'month': month,
      r'year': year,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TransactionDetailsByCodeModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'BCTransaction/GetTransactionDetailsByCode',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TransactionDetailsByCodeModel.fromJson(_result.data!);
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
