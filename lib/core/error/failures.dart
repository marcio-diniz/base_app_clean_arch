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
  const InputOfApplicationFailure(
      {super.message = inputOfApplicationFailureMessage});
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

class NoVehicleConnectionFailure extends Failure {
  const NoVehicleConnectionFailure({required super.message});
}

class LowQualityInputFailure extends Failure {
  const LowQualityInputFailure({required super.message});
}

class FaceDecentralizedFailure extends Failure {
  const FaceDecentralizedFailure({required super.message});
}

class FaceFarAwayFailure extends Failure {
  const FaceFarAwayFailure({required super.message});
}

class CacheIsEmptyFailure extends Failure {
  const CacheIsEmptyFailure({super.message = ''});
}

class CacheIsNotValidFailure extends Failure {
  const CacheIsNotValidFailure({super.message = ''});
}

class DownloadFailure extends Failure {
  const DownloadFailure({super.message = ''});
}

class AlreadyDoneFailure extends Failure {
  const AlreadyDoneFailure({super.message = ''});
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

// Event failure messages
const String getEventFailureMessage =
    'Desculpe, não foi possível buscar o evento. Tente novamente.';
const String getEventsFailureMessage =
    'Desculpe, não foi possível buscar os eventos. Tente novamente.';
const String getNewEventsFailureMessage =
    'Desculpe, não foi possível encontrar novos eventos. Tente novamente.';
const String getEventPhotoFailureMessage =
    'Desculpe, não foi possível buscar a foto do evento. Tente novamente.';
const String getEventBlockFailureMessage =
    'Desculpe, não foi possível buscar o evento de bloqueio. Tente novamente.';

// Internal snapshot failure message
const String sendingSnapshotImageRequestFailureMessage =
    'Desculpe, não foi possível solicitar uma foto. Tente novamente.';
const String conflictSnapshotImageRequestFailureMessage =
    'Por favor, aguarde a solicitação terminar para criar outra. Tente novamente mais tarde.';
const String getSnapshotImageListFailureMessage =
    'Desculpe, não foi possível listar as imagens. Tente novamente.';
const String getSnapshotImageFailureMessage =
    'Desculpe, não foi possível buscar a foto. Tente novamente.';
const String getLastSnapshotImageFailureMessage =
    'Desculpe, não foi possível buscar a última foto. Tente novamente.';
const String noVehicleConnectionSnapshotImageRequestFailureMessage =
    'Desculpe, não foi possível solicitar a foto. O veículo está sem conexão com a internet.';

// Vehicle failure messages
const String getVehicleByIdFailureMessage =
    'Desculpe, não foi possível buscar o veículo';
const String getVehicleListFailureMessage =
    'Desculpe, não foi possível buscar os veículos';
const String getVehicleLiveFailureMessage =
    'Desculpe, não foi possível carregar a live. Tente novamente';
const String blockVehicleFailureMessage =
    'Desculpe, não foi possível solicitar o bloqueio. Tente novamente';
const String unblockVehicleFailureMessage =
    'Desculpe, não foi possível solicitar o desbloqueio. Tente novamente';

// Vehicle Drivers
const String getVehicleDriverListFailureMessage =
    'Desculpe, não foi possível listar seus contatos de confiança. Tente novamente';
const String getVehicleDriverPendingListFailureMessage =
    'Desculpe, não foi possível listar seus contatos pendentes. Tente novamente';
const String addVehicleDriverListFailureMessage =
    'Desculpe, não foi possível adicionar o usuário aos seus contatos de confiança. Tente novamente';
const String removeVehicleDriverListFailureMessage =
    'Desculpe, não foi possível remover o usuário de seus contatos de confiança. Tente novamente';
const String removeVehicleDriverPendingListFailureMessage =
    'Desculpe, não foi possível cancelar o convite. Tente novamente';
const String getDriverPermissionListFailureMessage =
    'Desculpe, não foi possível buscar as permissões. Tente novamente';
const String getPermissionByDriverFailureMessage =
    'Desculpe, não foi possível buscar as permissões do contato de confiança. Tente novamente';
const String updateDriverPermissionsFailureMessage =
    'Desculpe, não foi possível atualizar as permissões do seu contato de confiança. Tente novamente';

// Vehicle position failure messages
const String getLastVehiclePositionFailureMessage =
    'Desculpe, não foi possível buscar a localização.';
const String getVehiclePositionListFailureMessage =
    'Desculpe, não foi possível buscar a localização.';
const String getVehiclePositionInputFailureMessage =
    'Revise o horário, o tempo não pode passar de 24h.';
const String getRoutesListFailureMessage =
    'Desculpe, não foi possível buscar os trajetos. Tente novamente.';
const String getRoutePositionListFailureMessage =
    'Desculpe, não foi possível buscar o trajeto percorrido. Tente novamente.';

// Vehicle anchor failure messages
const String getVehicleAnchorButtonFailureMessage =
    'Desculpe, não foi possível buscar se existe uma ancora ativa para o veículo.';
const String createVehicleAnchorButtonFailureMessage =
    'Desculpe, não foi ativar a ancora para o veículo.';
const String disableVehicleAnchorButtonFailureMessage =
    'Desculpe, não foi possível desativar a ancora para o veículo';

// Vehicle anchor failure messages
const String saveVehicleAccountAliasFailureMessage =
    'Desculpe, não foi possível salvar o apelido para o veículo.';

// Camera failure messages
const String initializeCameraFailureMessage =
    'Desculpe, não foi possível abrir a câmera. Tente novamente';
const String takeCameraFailureMessage =
    'Desculpe, não foi possível tirar a foto. Tente novamente';

// History failure messages
const String getHistoryRequestsFailureMessage =
    'Desculpe, não foi possível buscar os resgates. Tente novamente.';
const String getClipsByRequestFailureMessage =
    'Desculpe, não foi possível buscar as gravações do resgate. Tente novamente.';
const String getClipsAvailableToRequestFalilureMessage =
    'Desculpe, não foi possível buscar os clips disponíveis para resgate. Tente novamente.';
const String createRequestHistoryClipsMessageFailure =
    'Desculpe, não foi possível criar o resgate. Tente novamente.';
const String requestAvailableClipListFromCameraMessageFailure =
    'Falha no upload da lista para resgate.';

// Account
const String getMyAccountFailureMessage =
    'Desculpe, não foi possível buscar os dados da sua conta.';
const String updateInfoPushNotificationFailureMessage =
    'Desculpe, não foi possível atualizar as informações para que possa receber as notificações.';
const String uploadMySelfieFailureMessage =
    'Desculpe, não foi possível fazer o upload da selfie.';
const String acceptTermsAndConditionsFailureMessage =
    'Desculpe, não foi possível aceitar os termos de uso. Tente novamente.';
const String acceptPrivacyPolicyFailureMessage =
    'Desculpe, não foi possível aceitar a política de privacidade. Tente novamente.';

// App Settings
const String getAppSettingsFailureMessage =
    'Desculpe, não foi possível configurar o app. Tente mais tarde.';

// Face Recognition
const String myFaceRecognitionFailureMessage =
    'Desculpe, não foi possível validar sua foto. Tente novamente.';
const String myFaceRecognitionEmptyFailureMessage =
    'Desculpe, não conseguimos validar um rosto na sua foto. Tente novamente.';
const String myFaceRecognitionTooManyFailureMessage =
    'Desculpe, emcontramos mais de um rosto na sua foto. Tente novamente.';
const String myFaceRecognitionLowBrightnessFailureMessage =
    'Procure um local mais iluminado para tirar a foto.';
const String myFaceRecognitionFarAwayFailureMessage =
    'Aproxime um pouco o rosto e tire uma nova foto.';
const String myFaceRecognitionDecentralizedInYFailureMessage =
    'Centralize o rosto e tire uma nova foto.';
const String myFaceRecognitionDecentralizedUpwardsFailureMessage =
    'Abaixe um pouco o rosto e tire uma nova foto.';
const String myFaceRecognitionDecentralizedDownwardsFailureMessage =
    'Levante um pouco o rosto e tire uma nova foto.';

// Referral
const String addReferralListFailureMessage =
    'Desculpe, não foi possível adicionar o contato. Tente novamente.';
const String conflictAddReferralFailureMessage =
    'Desculpe, esse contato já contratou nossa proteção.';

// Bubbles
const String getBubblesFailureMessage =
    'Desculpe, não foi possível buscar as novidades. Tente novamente.';

// WebView
const String loadingPageWebViewFailureMessage =
    'Desculpe, não conseguimos carregar a página. Tente novamente.';

// Player
const String initializePlayerFailureMessage =
    'Desculpe, não foi possível carregar o player. Tente novamente.';
const String playlistIsEmptyFailureMessage =
    'Desculpe, não encontramos nenhum clip.';

// Download failure
const String downloadImageToGalleryFailureMessage =
    'Desculpe, não foi possível baixar a imagem para sua galeria. Tente novamente';
const String downloadVideoToGalleryFailureMessage =
    'Desculpe, não foi possível baixar o vídeo para sua galeria. Tente novamente';

// Notification Manager
const String getNotificationListFailureMessage =
    'Desculpe, não foi possível buscar as notificações. Tente novamente.';
const String updateNotificationPreferencesFailureMessage =
    'Desculpe, não foi possível atualizar suas preferências. Tente novamente.';

// Support
const String openSupportTicketFailureMessage =
    'Desculpe, não foi possível abrir o chamado. Tente novamente.';
