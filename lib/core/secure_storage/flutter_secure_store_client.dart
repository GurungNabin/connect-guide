import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStoreClient {
  final FlutterSecureStorage _storage;
  SecureStoreClient(this._storage);

  writeUserData(String email, String token, String userMasterId) async {
    print("Saved key: $token"); //added  //8403b4b41508521eaf66b37c872c5966
    // final iosOptions = IOSOptions(
    //   accountName: email,
    // );
    const iosOptions = IOSOptions(
      accountName: AppleOptions.defaultAccountName,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    await _storage.write(
      key: "user_email",
      value: email,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    await _storage.write(
      key: "user_token",
      value: token,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
    await _storage.write(
      key: "user_master_id",
      value: userMasterId,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  Future<String> readEmail() async {
    const iosOptions = IOSOptions(
      accountName: AppleOptions.defaultAccountName,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    final key = await _storage.read(
      key: "user_email",
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    if (key != null) {
      return key;
    }
    return "none";
  }

  void removeToken() async {
    const iosOptions = IOSOptions(
      accountName: AppleOptions.defaultAccountName,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    await _storage.delete(
      key: 'user_token',
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  void removeMasterId() async {
    const iosOptions = IOSOptions(
      accountName: AppleOptions.defaultAccountName,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    await _storage.delete(
      key: 'user_master_id',
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  Future<String> readUserMasterId() async {
    const iosOptions = IOSOptions(
      accountName: AppleOptions.defaultAccountName,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    final key = await _storage.read(
      key: "user_master_id",
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    if (key != null) {
      return key;
    }
    return "none";
  }

  Future<String> readToken() async {
    const iosOptions = IOSOptions(
      accountName: AppleOptions.defaultAccountName,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    final key = await _storage.read(
      key: "user_token",
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    if (key != null) {
      print(
          "Returned key: $key"); //added //54dd5545b495ec75252d11f24b24bf0b purno token return garxa
      return key;
    }
    return "none";
  }

  writePrivatePublicKey(
      String email, String privateKey, String publicKey) async {
    final iosOptions = IOSOptions(
      accountName: email,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    await _storage.write(
      key: "${email}_shoppercaddie_private_key",
      value: privateKey,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    await _storage.write(
      key: "${email}_shoppercaddie_public_key",
      value: publicKey,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  Future<String> readPrivateKey(String email) async {
    final iosOptions = IOSOptions(
      accountName: email,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    final key = await _storage.read(
      key: "${email}_shoppercaddie_private_key",
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    if (key != null) {
      return key;
    }
    return "none";
  }

  Future<String> readPublicKey(String email) async {
    final iosOptions = IOSOptions(
      accountName: email,
    );

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
      // sharedPreferencesName: 'Test2',
      // preferencesKeyPrefix: 'Test'
    );
    final key = await _storage.read(
      key: "${email}_shoppercaddie_public_key",
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    if (key != null) {
      return key;
    }
    return "none";
  }
}
