import 'package:flutter_test/flutter_test.dart';
import 'package:java_path/core/sync/sync_service.dart';

void main() {
  test('la synchronisation locale ne transmet aucune donnée', () async {
    const service = LocalOnlySyncService();

    final result = await service.synchronize(
      const SyncPayload(schemaVersion: 5, lastSyncAt: null),
    );

    expect(service.isConfigured, isFalse);
    expect(result.status, SyncStatus.offlineOnly);
    expect(result.uploadedItems, 0);
    expect(result.downloadedItems, 0);
  });
}
