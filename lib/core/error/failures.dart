import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  const Failure({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = serverFailureMessage});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({super.message = noInternetFailureMessage});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({required super.message});
}

class RefreshTokenFailure extends Failure {
  const RefreshTokenFailure({super.message = refreshTokenFailureMessage});
}

class DeviceConnectionFailure extends Failure {
  const DeviceConnectionFailure({super.message = ''});
}

class InputOfApplicationFailure extends Failure {
  const InputOfApplicationFailure({
    super.message = inputOfApplicationFailureMessage,
  });
}

class DataEmptyFailure extends Failure {
  const DataEmptyFailure({required super.message});
}

class DataTooManyFailure extends Failure {
  const DataTooManyFailure({required super.message});
}

class ConflictFailure extends Failure {
  const ConflictFailure({required super.message});
}

class CacheIsEmptyFailure extends Failure {
  const CacheIsEmptyFailure({super.message = ''});
}

class CacheIsNotValidFailure extends Failure {
  const CacheIsNotValidFailure({super.message = ''});
}

class AlreadyPhoneFailure extends Failure {
  const AlreadyPhoneFailure({required super.message});
}

class PaymentRequiredFailure extends Failure {
  const PaymentRequiredFailure({super.message = paymentRequiredFailureMessage});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message});
}

// Default failure messages
const String serverFailureMessage = 'Desculpe, ocorreu um erro interno.';
const String noInternetFailureMessage = 'Celular sem conexão com a internet.';
const String inputOfApplicationFailureMessage =
    'Desculpe, não conseguimos validar a chamada. Tente mais tarde.';
const String paymentRequiredFailureMessage =
    'Para continuar usando o app, é necessário contratar o serviço.';

// Auth
const String signUpFailureMessage =
    'Desculpe, não foi possível ativar sua conta.';
const String signUpAlreadyPhoneFailureMessage =
    'Desculpe, já existe uma conta com esse número de telefone.';
const String signInFailureMessage =
    'Desculpe, não foi possível fazer o login. Tente novamente.';
const String phoneOrPasswordInvalidFailureMessage =
    'Desculpe, o número de telefone ou a senha estão incorretos.';
const String accountPhoneNotFoundFailureMessage =
    'Desculpe, não encontramos nenhuma conta associada a este telefone.';
const String forgotPasswordFailureMessage =
    'Desculpe, não foi possível prosseguir para a troca da senha. Tente novamente.';
const String confirmationForgotPasswordFailureMessage =
    'Desculpe, não foi possível alterar sua senha. Tente novamente.';
const String invalidConfirmationCodeFailureMessage =
    'O código informado é inválido ou expirou. Verifique o código e tente novamente.';
const String signOutFailureMessage =
    'Desculpe, não foi possível sair da sua conta. Tente novamente.';
const String refreshTokenFailureMessage =
    'Sua sessão expirou. Por favor, faça o login novamente.';

// Account
const String getMyAccountFailureMessage =
    'Desculpe, não foi possível buscar os dados da sua conta.';
const String updateInfoPushNotificationFailureMessage =
    'Desculpe, não foi possível atualizar as informações para que possa receber as notificações.';
const String acceptTermsAndConditionsFailureMessage =
    'Desculpe, não foi possível aceitar os termos de uso. Tente novamente.';
const String acceptPrivacyPolicyFailureMessage =
    'Desculpe, não foi possível aceitar a política de privacidade. Tente novamente.';

// App Settings
const String getAppSettingsFailureMessage =
    'Desculpe, não foi possível configurar o app. Tente mais tarde.';

// WebView
const String loadingPageWebViewFailureMessage =
    'Desculpe, não conseguimos carregar a página. Tente novamente.';

// Support
const String openSupportTicketFailureMessage =
    'Desculpe, não foi possível abrir o chamado. Tente novamente.';
