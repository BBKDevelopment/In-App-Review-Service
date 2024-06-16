part of 'in_app_review_service.dart';

/// {@template in_app_review_service_exception}
/// Exception thrown when an error occurs in the InAppReviewService.
/// {@endtemplate}
sealed class InAppReviewServiceException implements Exception {
  /// {@macro in_app_review_service_exception}
  const InAppReviewServiceException();
}

/// {@template request_review_exception}
/// Exception thrown when the device is unable to show a review dialog.
/// {@endtemplate}
final class RequestReviewException extends InAppReviewServiceException {
  /// {@macro request_review_exception}
  const RequestReviewException();
}

/// {@template open_store_listing_exception}
/// Exception thrown when the device is unable to open the store listing.
/// {@endtemplate}
final class OpenStoreListingException extends InAppReviewServiceException {
  /// {@macro open_store_listing_exception}
  const OpenStoreListingException();
}
