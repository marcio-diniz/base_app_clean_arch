import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/services/analytics/i_analytics_service.dart';
import '../../repository/i_account_repository.dart';
import '../../repository/i_auth_repository.dart';
import 'i_sign_in_use_case.dart';

class SignInUseCase implements ISignInUseCase {
  const SignInUseCase({
    required this.authRepository,
    required this.accountRepository,
    required this.authManager,
    required this.analyticsService,
  });
  final IAuthRepository authRepository;
  final IAccountRepository accountRepository;
  final IAuthManager authManager;
  final IAnalyticsService analyticsService;

  @override
  Future<Either<Failure, void>> call({
    required String phone,
    required String password,
  }) async {
    final resposne = await authRepository.signIn(
      phone: phone,
      password: password,
    );
    return await resposne.fold((failure) => Left(failure), (response) async {
      await authManager.signIn(
        authenticationToken: response.accessToken,
        refreshAuthenticationToken: response.refreshToken,
        expiresIn: response.expiresIn,
        authUid: response.userId,
      );
      await analyticsService.setUserId(id: response.userId);
      await accountRepository.registerAppOpened();
      return const Right(null);
    });
  }
}
