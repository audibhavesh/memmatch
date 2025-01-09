enum AppResponseType {
  // General responses
  empty,
  success,
  error,
  somethingWentWrong,

  // User-related responses
  userNotFound,
  wrongPassword,
  userAlreadyExists,
  invalidUsername,
  weakPassword,
  userVerified,
  userIsNotVerified,

  // OTP and verification
  onOtpSent,
  invalidOtpCode,
  onOTPReceived,
  cannotReadOtp,

  // Data operation errors
  onDataCreateError,
  onDataReadError,
  dataNotFound,

  // File upload and download
  fileUploadFailed,
  fileUploadSuccess,
  fileUploadAborted,
  fileDownloadFailed,
  fileDownloadSuccess,

  // Network-related responses
  internetNotConnected,
  connectionTimeout,
  requestCanceled,

  // API response issues
  unauthorized,
  forbidden,
  notFound,
  badRequest,
  serverError,
  serviceUnavailable,
  receiveTimeout,
  sendTimeout,
  retrying,

  // Custom application-specific
  invalidCredentials,
  accessDenied,
  sessionExpired,
  paymentRequired,
  accountSuspended,

  // Operation-specific
  operationInProgress,
  operationCompleted,
  operationFailed,
  operationAborted,

  // Normal state or default fallback
  normal,
  failed,
  warning
}
