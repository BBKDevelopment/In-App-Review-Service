// Copyright 2024 BBK Development. All rights reserved.
// Use of this source code is governed by a Apache-2.0-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validates for copyright headers', () {
    test('... in lib', () async {
      await validate('lib');
    });

    test('... in test', () async {
      await validate('test');
    });
  });
}

Future<void> validate(String dir) async {
  final violations = <String>[];

  await for (final entity
      in Directory(dir).list(recursive: true, followLinks: false)) {
    if (entity is! File) continue;
    if (!entity.path.endsWith('.dart')) continue;
    if (entity.path.contains('/l10n/')) continue;
    if (entity.path.split('.').length > 2) continue;

    final file = await entity.open();
    final bytes = await file.read(40);
    final header = String.fromCharCodes(bytes);

    if (!header
        .startsWith(RegExp('// Copyright 20[0-9][0-9] BBK Development'))) {
      violations.add(entity.path);
    }
  }

  expect(
    violations,
    isEmpty,
    reason: 'Files missing copyright headers.'
        '\n\nSee CONTRIBUTING.md for format details.',
  );
}
