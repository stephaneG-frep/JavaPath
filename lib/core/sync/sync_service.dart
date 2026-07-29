enum SyncStatus { offlineOnly, ready, syncing, success, error }

class SyncResult {
  const SyncResult({
    required this.status,
    required this.message,
    required this.uploadedItems,
    required this.downloadedItems,
  });

  final SyncStatus status;
  final String message;
  final int uploadedItems;
  final int downloadedItems;
}

class SyncPayload {
  const SyncPayload({
    required this.schemaVersion,
    required this.lastSyncAt,
  });

  final int schemaVersion;
  final DateTime? lastSyncAt;
}

abstract interface class SyncService {
  bool get isConfigured;
  Future<SyncResult> synchronize(SyncPayload payload);
}

class LocalOnlySyncService implements SyncService {
  const LocalOnlySyncService();

  @override
  bool get isConfigured => false;

  @override
  Future<SyncResult> synchronize(SyncPayload payload) async {
    return const SyncResult(
      status: SyncStatus.offlineOnly,
      message: 'Synchronisation distante non configurée. '
          'Les données restent uniquement sur cet appareil.',
      uploadedItems: 0,
      downloadedItems: 0,
    );
  }
}
