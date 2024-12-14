import 'package:flutter_test/flutter_test.dart';
import 'package:ticno_deta_recovery/services/file_recovery_service.dart';

void main() {
  group('FileRecoveryService', () {
    final service = FileRecoveryService();

    test('getDeletedFiles returns a list of files', () async {
      final files = await service.getDeletedFiles('video');
      expect(files, isA<List<Map<String, dynamic>>>());
    });

    test('getDeletedFiles handles unknown file type gracefully', () async {
      try {
        await service.getDeletedFiles('unknown');
      } catch (e) {
        expect(e, isA<String>());
      }
    });
  });
}
