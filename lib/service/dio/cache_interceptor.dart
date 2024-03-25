import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hive/hive.dart';

CacheOptions buildCacheOptions(CacheStore cacheStore) {
  return CacheOptions(
    store: cacheStore,
  );
}

HiveCacheStore buildHiveCacheStore(String? directory, [HiveCipher? encryptionCipher]) {
  return HiveCacheStore(
    directory,
    encryptionCipher: encryptionCipher,
  );
}

DioCacheInterceptor buildDioCacheInterceptor(CacheOptions cacheOptions) {
  return DioCacheInterceptor(options: cacheOptions);
}
