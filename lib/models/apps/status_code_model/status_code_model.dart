/// A model representing an HTTP status code and its corresponding message.
class StatusCodeModel {
  final int code;
  final String message;

  const StatusCodeModel({required this.code, required this.message});

  /// Factory constructor to create a `StatusCodeModel` using predefined constants.
  factory StatusCodeModel.fromCode(int code) {
    final model = _statusModels[code];
    if (model == null) {
      throw ArgumentError('Unsupported HTTP status code: $code');
    }
    return model;
  }

  // Predefined constants for common status codes
  static const StatusCodeModel success = StatusCodeModel(
    code: 200,
    message:
        'The request was successful, and the server responded with the requested data.',
  );

  static const StatusCodeModel error = StatusCodeModel(
    code: 500,
    message: 'A generic error occurred on the server.',
  );

  static const StatusCodeModel notFound = StatusCodeModel(
    code: 404,
    message: 'The requested resource could not be found on the server.',
  );

  static const StatusCodeModel badRequest = StatusCodeModel(
    code: 400,
    message:
        'The server could not understand the request due to invalid syntax.',
  );

  static const StatusCodeModel unauthorized = StatusCodeModel(
    code: 401,
    message:
        'The client must authenticate itself to get the requested response.',
  );

  static const StatusCodeModel forbidden = StatusCodeModel(
    code: 403,
    message: 'The client does not have access rights to the content.',
  );

  static const StatusCodeModel conflict = StatusCodeModel(
    code: 409,
    message:
        'The request could not be completed due to a conflict with the current state of the resource.',
  );

  static const StatusCodeModel internalServerError = StatusCodeModel(
    code: 500,
    message: 'A generic error occurred on the server.',
  );

  static const StatusCodeModel notImplemented = StatusCodeModel(
    code: 501,
    message:
        'The server does not support the functionality required to fulfill the request.',
  );

  static const StatusCodeModel badGateway = StatusCodeModel(
    code: 502,
    message:
        'The server received an invalid response from the upstream server.',
  );

  static const StatusCodeModel serviceUnavailable = StatusCodeModel(
    code: 503,
    message:
        'The server is not ready to handle the request, usually due to maintenance or overload.',
  );

  static const StatusCodeModel gatewayTimeout = StatusCodeModel(
    code: 504,
    message:
        'The server did not receive a timely response from the upstream server.',
  );

  static const StatusCodeModel httpVersionNotSupported = StatusCodeModel(
    code: 505,
    message:
        'The server does not support the HTTP protocol version used in the request.',
  );

  /// Internal map to support quick lookup by code
  static const Map<int, StatusCodeModel> _statusModels = {
    200: success,
    400: badRequest,
    401: unauthorized,
    403: forbidden,
    404: notFound,
    409: conflict,
    500: error,
    501: notImplemented,
    502: badGateway,
    503: serviceUnavailable,
    504: gatewayTimeout,
    505: httpVersionNotSupported,
  };
}
