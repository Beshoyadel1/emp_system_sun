import '../../../../core/language/language_constant.dart';


String responseOfStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return AppLanguageKeys.badRequestError;

    case 401:
      return AppLanguageKeys.unauthorizedError;

    case 403:
      return AppLanguageKeys.forbiddenError;

    case 404:
      return AppLanguageKeys.requestNotFound;

    case 405:
      return AppLanguageKeys.methodNotAllowed;

    case 408:
      return AppLanguageKeys.requestTimeout;

    case 409:
      return AppLanguageKeys.conflictError;

    case 422:
      return AppLanguageKeys.validationError;

    case 429:
      return AppLanguageKeys.tooManyRequests;

    case 500:
      return AppLanguageKeys.internalServerError;

    case 502:
      return AppLanguageKeys.badGateway;

    case 503:
      return AppLanguageKeys.serviceUnavailable;

    case 504:
      return AppLanguageKeys.gatewayTimeout;
  //  No internet / unknown
    case null:
      return AppLanguageKeys.noInternetConnection;

    default:
      return AppLanguageKeys.oopsErrorTryAgain;
  }
}

