import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/services/analytics/i_analytics_service.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repository/i_account_repository.dart';
import '../../repository/i_auth_repository.dart';
import 'i_register_user_use_case.dart';

class RegisterUserUseCase implements IRegisterUserUseCase {
  const RegisterUserUseCase({
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
    required int termsVersion,
    required int privacyPolicyVersion,
  }) async {
    final signUpEither = await authRepository.signUp(
      phone: phone,
      password: password,
      termsVersion: termsVersion,
      privacyPolicyVersion: privacyPolicyVersion,
    );
    return signUpEither.fold((failure) => Left(failure), (signUpSuccess) async {
      final signInEither = await authRepository.signIn(
        phone: phone,
        password: password,
      );
      return signInEither.fold((failure) => Left(failure), (
        signInSuccess,
      ) async {
        await authManager.signIn(
          authenticationToken: signInSuccess.accessToken,
          refreshAuthenticationToken: signInSuccess.refreshToken,
          expiresIn: signInSuccess.expiresIn,
          authUid: signInSuccess.userId,
        );
        await analyticsService.setUserId(id: signInSuccess.userId);
        await accountRepository.registerAppOpened();
        return const Right(null);
      });
    });
  }
}
