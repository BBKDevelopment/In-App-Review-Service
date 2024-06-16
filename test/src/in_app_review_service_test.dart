// Copyright 2024 BBK Development. All rights reserved.
// Use of this source code is governed by a Apache-2.0-style license that can be
// found in the LICENSE file.

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_review_service/src/in_app_review_service.dart';
import 'package:mocktail/mocktail.dart';

final class _MockInAppReview extends Mock implements InAppReview {}

void main() {
  late InAppReviewService sut;
  late InAppReview mockInAppReview;

  setUp(() {
    // Setup code that runs before each test.
    mockInAppReview = _MockInAppReview();
    sut = InAppReviewService.test(inAppReview: mockInAppReview);
  });

  void mockIsAvailable({
    required bool isAvailable,
    required bool throwError,
  }) {
    if (throwError) {
      when(() => mockInAppReview.isAvailable()).thenThrow(Exception());
      return;
    }

    when(() => mockInAppReview.isAvailable())
        .thenAnswer((_) async => isAvailable);
  }

  void mockRequestReview({
    required bool throwError,
  }) {
    if (throwError) {
      when(() => mockInAppReview.requestReview()).thenThrow(Exception());
      return;
    }

    when(() => mockInAppReview.requestReview()).thenAnswer((_) async {});
  }

  void mockOpenStoreListing({
    required bool throwError,
  }) {
    if (throwError) {
      when(() => mockInAppReview.openStoreListing()).thenThrow(Exception());
      return;
    }

    when(() => mockInAppReview.openStoreListing()).thenAnswer((_) async {});
  }

  group('InAppReviewService', () {
    test('can be instantiated', () {
      expect(InAppReviewService(), isNotNull);
    });

    test(
        'isAvailable method returns true when the device is able '
        'to show a review dialog', () async {
      mockIsAvailable(isAvailable: true, throwError: false);
      final isAvailable = await sut.isAvailable();
      expect(isAvailable, isTrue);
    });

    test(
        'isAvailable method returns false when the device is unable to '
        'show a review dialog', () async {
      mockIsAvailable(isAvailable: false, throwError: true);
      final isAvailable = await sut.isAvailable();
      expect(isAvailable, isFalse);
    });

    test(
        'requestReview method shows the review dialog when the device is able '
        'to show a review dialog', () async {
      mockRequestReview(throwError: false);
      await sut.requestReview();
      verify(() => mockInAppReview.requestReview()).called(1);
    });

    test(
        'requestReview method throws a RequestReviewException when the device '
        'is unable to show a review dialog', () async {
      mockRequestReview(throwError: true);
      expect(() => sut.requestReview(), throwsA(isA<RequestReviewException>()));
    });

    test(
        'openStoreListing method opens the store listing when the device is '
        'able to show a review dialog', () async {
      mockOpenStoreListing(throwError: false);
      await sut.openStoreListing();
      verify(() => mockInAppReview.openStoreListing()).called(1);
    });

    test(
        'openStoreListing method throws an exception when the device is  unable'
        ' to show a review dialog', () async {
      mockOpenStoreListing(throwError: true);
      expect(
        () => sut.openStoreListing(),
        throwsA(isA<OpenStoreListingException>()),
      );
    });
  });
}
