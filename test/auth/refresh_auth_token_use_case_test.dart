import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/error/failures.dart';
import 'package:base_app_clean_arch/domain/repository/i_auth_repository.dart';
import 'package:base_app_clean_arch/domain/entity/refresh_token_response_entity.dart';
import 'package:base_app_clean_arch/domain/usecase/auth/refresh_auth_token_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockAuthManager extends Mock implements IAuthManager {}

void main() {
  late RefreshAuthTokenUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late MockAuthManager mockAuthManager;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAuthManager = MockAuthManager();

    useCase = RefreshAuthTokenUseCase(
      authRepository: mockAuthRepository,
      authManager: mockAuthManager,
    );
  });

  const accessToken = 'new_access_token';
  const expiresIn = 3600;

  const refreshTokenResponse = RefreshTokenResponseEntity(
    accessToken: accessToken,
    expiresIn: expiresIn,
  );

  const failure = Failure(message: 'Failed to refresh token');

  group('RefreshAuthTokenUseCase', () {
    test('should refresh token successfully', () async {
      when(
        () => mockAuthRepository.refreshToken(),
      ).thenAnswer((_) async => const Right(refreshTokenResponse));

      when(
        () => mockAuthManager.refreshToken(
          authenticationToken: accessToken,
          expiresIn: expiresIn,
        ),
      ).thenAnswer((_) async => Future.value());

      final result = await useCase();
      expect(result, const Right(null));
      verify(() => mockAuthRepository.refreshToken()).called(1);
      verify(
        () => mockAuthManager.refreshToken(
          authenticationToken: accessToken,
          expiresIn: expiresIn,
        ),
      ).called(1);
    });

    test('should return Failure when refreshToken fails', () async {
      when(
        () => mockAuthRepository.refreshToken(),
      ).thenAnswer((_) async => const Left(failure));

      final result = await useCase();
      expect(result, const Left(failure));
      verify(() => mockAuthRepository.refreshToken()).called(1);
      verifyNever(
        () => mockAuthManager.refreshToken(
          authenticationToken: accessToken,
          expiresIn: expiresIn,
        ),
      );
    });
  });
}
