import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repository/i_account_repository.dart';
import '../push_notification/i_update_info_push_notification_use_case.dart';

class UpdateInfoPushNotificationUseCase
    implements IUpdateInfoPushNotificationUseCase {
  const UpdateInfoPushNotificationUseCase({required this.accountRepository});
  final IAccountRepository accountRepository;

  @override
  Future<Either<Failure, void>> call({
    required String? firebaseToken,
    required bool enabledPermission,
  }) => accountRepository.updatePushPermission(
    firebaseToken: firebaseToken,
    enabledPermission: enabledPermission,
  );
}
