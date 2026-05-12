import 'dart:async';

import 'package:base_app_clean_arch/core/auth/const_auth.dart';
import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/services/local_storage/i_secure_storage_service.dart';
import 'package:base_app_clean_arch/core/util/phone_utils.dart';

export 'auth_manager.dart';

class AuthManager implements IAuthManager {
  AuthManager({required this.secureStorageService});
  final ISecureStorageService secureStorageService;

  String? _authenticationToken;
  String? _refreshAutenticationToken;
  DateTime? _tokenExpiration;
  String? _uid;
  String? _phoneNumber;
  String? _password;
  bool? _enableBiometric;

  @override
  Future<void> initialize() async {
    try {
      _authenticationToken = await secureStorageService.getString(
        key: ConstAuth.kAuthTokenKey,
      );
      _refreshAutenticationToken = await secureStorageService.getString(
        key: ConstAuth.kRefreshAuthTokenKey,
      );
      _uid = await secureStorageService.getString(key: ConstAuth.kUidKey);
      final timestampExpiration = await secureStorageService.getInt(
        key: ConstAuth.kTokenExpirationKey,
      );
      _tokenExpiration = timestampExpiration != null
          ? DateTime.fromMillisecondsSinceEpoch(timestampExpiration)
          : null;
      _phoneNumber = await secureStorageService.getString(
        key: ConstAuth.phoneNumberKey,
      );
      _password = await secureStorageService.getString(
        key: ConstAuth.passwordKey,
      );
      _enableBiometric = await secureStorageService.getBool(
        key: ConstAuth.enableBiometricKey,
      );
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> signIn({
    required String authenticationToken,
    required String refreshAuthenticationToken,
    required int expiresIn,
    required String authUid,
  }) async {
    _authenticationToken = authenticationToken;
    _refreshAutenticationToken = refreshAuthenticationToken;
    final tokenExpiration = _dateTimeExpireToken(expiresIn);
    _tokenExpiration = tokenExpiration;
    _uid = authUid;

    await secureStorageService.setString(
      key: ConstAuth.kAuthTokenKey,
      data: authenticationToken,
    );
    await secureStorageService.setString(
      key: ConstAuth.kRefreshAuthTokenKey,
      data: refreshAuthenticationToken,
    );
    await secureStorageService.setInt(
      key: ConstAuth.kTokenExpirationKey,
      data: tokenExpiration.millisecondsSinceEpoch,
    );
    await secureStorageService.setString(key: ConstAuth.kUidKey, data: authUid);
  }

  @override
  Future<void> refreshToken({
    required String authenticationToken,
    required int expiresIn,
  }) async {
    _authenticationToken = authenticationToken;
    final tokenExpiration = _dateTimeExpireToken(expiresIn);
    _tokenExpiration = tokenExpiration;

    await secureStorageService.setString(
      key: ConstAuth.kAuthTokenKey,
      data: authenticationToken,
    );
    await secureStorageService.setInt(
      key: ConstAuth.kTokenExpirationKey,
      data: tokenExpiration.millisecondsSinceEpoch,
    );
  }

  @override
  Future<void> signOut() async {
    _authenticationToken = null;
    _refreshAutenticationToken = null;
    _tokenExpiration = null;
    _uid = null;

    await secureStorageService.clearValue(key: ConstAuth.kAuthTokenKey);
    await secureStorageService.clearValue(key: ConstAuth.kRefreshAuthTokenKey);
    await secureStorageService.clearValue(key: ConstAuth.kTokenExpirationKey);
    await secureStorageService.clearValue(key: ConstAuth.kUidKey);

    await secureStorageService.setBool(
      key: ConstAuth.enableBiometricKey,
      data: false,
    );
    _enableBiometric = false;
  }

  @override
  Future<void> setPhoneNumber({required String phoneNumber}) async {
    final cleanedPhone = PhoneUtils.cleanPhoneNumber(phone: phoneNumber);
    _phoneNumber = cleanedPhone;
    await secureStorageService.setString(
      key: ConstAuth.phoneNumberKey,
      data: cleanedPhone,
    );
  }

  @override
  Future<void> setPassword({required String password}) async {
    _password = password;
    await secureStorageService.setString(
      key: ConstAuth.passwordKey,
      data: password,
    );
  }

  @override
  Future<void> setEnableBiometrics({required bool enable}) async {
    _enableBiometric = enable;
    await secureStorageService.setBool(
      key: ConstAuth.enableBiometricKey,
      data: enable,
    );
  }

  @override
  String? get currentAuthenticationToken => _authenticationToken;

  @override
  String? get currentRefreshAuthenticationToken => _refreshAutenticationToken;

  @override
  DateTime? get tokenExpiration => _tokenExpiration;

  @override
  String? get currentUserUid => _uid;

  @override
  String get countryCode => '+55';

  @override
  String? get phoneNumber => _phoneNumber;

  @override
  String? get fullPhoneNumber =>
      _phoneNumber != null ? '$countryCode$_phoneNumber' : null;

  @override
  String? get password => _password;

  @override
  bool get enableBiometric => _enableBiometric ?? false;

  @override
  bool get loggedIn =>
      _authenticationToken != null &&
      _tokenExpiration != null &&
      _tokenExpiration!.isAfter(DateTime.now());

  DateTime _dateTimeExpireToken(int secondsAdd) {
    final today = DateTime.now();
    final timeAdded = today.add(Duration(seconds: secondsAdd));
    return timeAdded;
  }
}
