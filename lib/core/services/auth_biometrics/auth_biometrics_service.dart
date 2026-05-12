import 'package:base_app_clean_arch/core/services/auth_biometrics/i_auth_biometrics_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class AuthBiometricsService implements IAuthBiometricsService {
  @override
  Future<bool> authenticate() async {
    bool biometricOutput = false;

    final localAuth = LocalAuthentication();
    bool isBiometricSupported = await localAuth.isDeviceSupported();

    if (isBiometricSupported) {
      try {
        biometricOutput = await localAuth.authenticate(
          localizedReason: 'Realize a autenticação para logar na BusCAR!',
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Autenticação necessária',
              signInHint: '',
              cancelButton: 'Cancelar',
            ),
            IOSAuthMessages(cancelButton: 'Cancelar'),
          ],
        );
      } catch (e) {
        biometricOutput = false;
      }
    }

    return biometricOutput;
  }
}
