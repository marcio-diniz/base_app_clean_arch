abstract class IAuthManager {
  Future<void> initialize();

  Future<void> signIn({
    required String authenticationToken,
    required String refreshAuthenticationToken,
    required int expiresIn,
    required String authUid,
  });

  Future<void> refreshToken({
    required String authenticationToken,
    required int expiresIn,
  });

  Future<void> signOut();

  Future<void> setPhoneNumber({required String phoneNumber});

  Future<void> setPassword({required String password});

  Future<void> setEnableBiometrics({required bool enable});

  String? get currentAuthenticationToken;

  String? get currentRefreshAuthenticationToken;

  DateTime? get tokenExpiration;

  String? get currentUserUid;

  String get countryCode;

  String? get phoneNumber;

  String? get fullPhoneNumber;

  String? get password;

  bool get enableBiometric;

  bool get loggedIn;
}
