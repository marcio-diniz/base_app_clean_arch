import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/error/failures.dart';
import 'package:base_app_clean_arch/core/services/analytics/i_analytics_service.dart';
import 'package:base_app_clean_arch/domain/repository/i_account_repository.dart';
import 'package:base_app_clean_arch/domain/repository/i_auth_repository.dart';
import 'package:base_app_clean_arch/domain/usecase/auth/sign_in_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../core/factory/sign_in_response_factory.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockAuthManager extends Mock implements IAuthManager {}

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late SignInUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late MockAccountRepository mockAccountRepository;
  late MockAuthManager mockAuthManager;
  late MockAnalyticsService mockAnalytics;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAccountRepository = MockAccountRepository();
    mockAuthManager = MockAuthManager();
    mockAnalytics = MockAnalyticsService();

    useCase = SignInUseCase(
      authRepository: mockAuthRepository,
      accountRepository: mockAccountRepository,
      authManager: mockAuthManager,
      analyticsService: mockAnalytics,
    );
  });
  final phone = "+5511999999999";
  final password = "password";

  final signInResponseEntity = SignInResponseFactory().createEntity();

  group('SignInUseCase', () {
    test('should sign in the user successfully', () async {
      when(
        () => mockAuthRepository.signIn(phone: phone, password: password),
      ).thenAnswer((_) async => Right(signInResponseEntity));

      when(
        () => mockAuthManager.signIn(
          authenticationToken: signInResponseEntity.accessToken,
          refreshAuthenticationToken: signInResponseEntity.refreshToken,
          expiresIn: signInResponseEntity.expiresIn,
          authUid: signInResponseEntity.userId,
        ),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockAnalytics.setUserId(id: signInResponseEntity.userId),
      ).thenAnswer((_) async {});

      when(
        () => mockAccountRepository.registerAppOpened(),
      ).thenAnswer((_) async => const Right(null));

      final result = await useCase(phone: phone, password: password);

      expect(result, const Right(null));
      verify(
        () => mockAuthRepository.signIn(phone: phone, password: password),
      ).called(1);
      verify(
        () => mockAuthManager.signIn(
          authenticationToken: signInResponseEntity.accessToken,
          refreshAuthenticationToken: signInResponseEntity.refreshToken,
          expiresIn: signInResponseEntity.expiresIn,
          authUid: signInResponseEntity.userId,
        ),
      ).called(1);
      verify(
        () => mockAnalytics.setUserId(id: signInResponseEntity.userId),
      ).called(1);
      verify(() => mockAccountRepository.registerAppOpened()).called(1);
    });

    test('should return Failure when signIn fails', () async {
      const failure = Failure(message: 'Sign in failed');

      when(
        () => mockAuthRepository.signIn(phone: phone, password: password),
      ).thenAnswer((_) async => const Left(failure));

      final result = await useCase(phone: phone, password: password);

      expect(result, const Left(failure));
      verify(
        () => mockAuthRepository.signIn(phone: phone, password: password),
      ).called(1);
      verifyNever(
        () => mockAuthManager.signIn(
          authenticationToken: signInResponseEntity.accessToken,
          refreshAuthenticationToken: signInResponseEntity.refreshToken,
          expiresIn: signInResponseEntity.expiresIn,
          authUid: signInResponseEntity.userId,
        ),
      );
      verifyNever(
        () => mockAnalytics.setUserId(id: signInResponseEntity.userId),
      );
      verifyNever(() => mockAccountRepository.registerAppOpened());
    });
  });
}
