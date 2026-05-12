import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repository/i_auth_repository.dart';
import 'i_refresh_auth_token_use_case.dart';

class RefreshAuthTokenUseCase implements IRefreshAuthTokenUseCase {
  const RefreshAuthTokenUseCase({
    required this.authRepository,
    required this.authManager,
  });
  final IAuthRepository authRepository;
  final IAuthManager authManager;

  @override
  Future<Either<Failure, void>> call() async {
    final refreshTokenEither = await authRepository.refreshToken();
    return refreshTokenEither.fold((failure) => Left(failure), (
      refreshTokenSuccess,
    ) async {
      await authManager.refreshToken(
        authenticationToken: refreshTokenSuccess.accessToken,
        expiresIn: refreshTokenSuccess.expiresIn,
      );
      return const Right(null);
    });
  }
}
