import 'package:base_app_clean_arch/core/auth/i_auth_manager.dart';
import 'package:base_app_clean_arch/core/error/failures.dart';
import 'package:base_app_clean_arch/core/services/analytics/i_analytics_service.dart';
import 'package:base_app_clean_arch/domain/repository/i_account_repository.dart';
import 'package:base_app_clean_arch/domain/repository/i_auth_repository.dart';
import 'package:base_app_clean_arch/domain/entity/sign_in_response_entity.dart';
import 'package:base_app_clean_arch/domain/entity/sign_up_response_entity.dart';
import 'package:base_app_clean_arch/domain/usecase/auth/register_user_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockAuthManager extends Mock implements IAuthManager {}

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late RegisterUserUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  late MockAccountRepository mockAccountRepository;
  late MockAuthManager mockAuthManager;
  late MockAnalyticsService mockAnalytics;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAccountRepository = MockAccountRepository();
    mockAuthManager = MockAuthManager();
    mockAnalytics = MockAnalyticsService();

    useCase = RegisterUserUseCase(
      authRepository: mockAuthRepository,
      accountRepository: mockAccountRepository,
      authManager: mockAuthManager,
      analyticsService: mockAnalytics,
    );
  });

  const phone = '1234567890';
  const password = 'password123';
  const termsVersion = 1;
  const privacyPolicyVersion = 1;

  const accessToken = 'access_token';
  const refreshToken = 'refresh_token';
  const userId = 'user123';
  const expiresIn = 3600;

  test('should register and sign in the user successfully', () async {
    // Arrange

    when(
      () => mockAuthRepository.signUp(
        phone: phone,
        password: password,
        termsVersion: termsVersion,
        privacyPolicyVersion: privacyPolicyVersion,
      ),
    ).thenAnswer(
      (_) async => const Right(SignUpResponseEntity(userId: 'user123')),
    );

    when(
      () => mockAuthRepository.signIn(phone: phone, password: password),
    ).thenAnswer(
      (_) async => const Right(
        SignInResponseEntity(
          accessToken: accessToken,
          refreshToken: refreshToken,
          userId: userId,
          expiresIn: expiresIn,
        ),
      ),
    );

    when(
      () => mockAuthManager.signIn(
        authenticationToken: accessToken,
        refreshAuthenticationToken: refreshToken,
        expiresIn: expiresIn,
        authUid: userId,
      ),
    ).thenAnswer((_) async => Future.value());

    when(() => mockAnalytics.setUserId(id: userId)).thenAnswer((_) async {});

    when(
      () => mockAccountRepository.registerAppOpened(),
    ).thenAnswer((_) async => const Right(null));

    final result = await useCase(
      phone: phone,
      password: password,
      termsVersion: termsVersion,
      privacyPolicyVersion: privacyPolicyVersion,
    );

    expect(result, const Right(null));
    verify(
      () => mockAuthRepository.signUp(
        phone: phone,
        password: password,
        termsVersion: termsVersion,
        privacyPolicyVersion: privacyPolicyVersion,
      ),
    ).called(1);
    verify(
      () => mockAuthRepository.signIn(phone: phone, password: password),
    ).called(1);
    verify(
      () => mockAuthManager.signIn(
        authenticationToken: accessToken,
        refreshAuthenticationToken: refreshToken,
        expiresIn: expiresIn,
        authUid: userId,
      ),
    ).called(1);
    verify(() => mockAnalytics.setUserId(id: userId)).called(1);
    verify(() => mockAccountRepository.registerAppOpened()).called(1);
  });

  test('should return Failure when signUp fails', () async {
    // Arrange
    const failure = Failure(message: 'Sign up failed');

    when(
      () => mockAuthRepository.signUp(
        phone: phone,
        password: password,
        termsVersion: termsVersion,
        privacyPolicyVersion: privacyPolicyVersion,
      ),
    ).thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(
      phone: phone,
      password: password,
      termsVersion: termsVersion,
      privacyPolicyVersion: privacyPolicyVersion,
    );

    // Assert
    expect(result, const Left(failure));
    verify(
      () => mockAuthRepository.signUp(
        phone: phone,
        password: password,
        termsVersion: termsVersion,
        privacyPolicyVersion: privacyPolicyVersion,
      ),
    ).called(1);
    verifyNever(
      () => mockAuthRepository.signIn(phone: phone, password: password),
    );
    verifyNever(
      () => mockAuthManager.signIn(
        authenticationToken: accessToken,
        refreshAuthenticationToken: refreshToken,
        expiresIn: expiresIn,
        authUid: userId,
      ),
    );

    verifyNever(() => mockAnalytics.setUserId(id: userId));
    verifyNever(() => mockAccountRepository.registerAppOpened());
  });

  test('should return Failure when signIn fails', () async {
    // Arrange
    const failure = Failure(message: 'Sign in failed');

    when(
      () => mockAuthRepository.signUp(
        phone: phone,
        password: password,
        termsVersion: termsVersion,
        privacyPolicyVersion: privacyPolicyVersion,
      ),
    ).thenAnswer(
      (_) async => const Right(SignUpResponseEntity(userId: 'user123')),
    );

    when(
      () => mockAuthRepository.signIn(phone: phone, password: password),
    ).thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(
      phone: phone,
      password: password,
      termsVersion: termsVersion,
      privacyPolicyVersion: privacyPolicyVersion,
    );

    // Assert
    expect(result, const Left(failure));
    verify(
      () => mockAuthRepository.signUp(
        phone: phone,
        password: password,
        termsVersion: termsVersion,
        privacyPolicyVersion: privacyPolicyVersion,
      ),
    ).called(1);
    verify(
      () => mockAuthRepository.signIn(phone: phone, password: password),
    ).called(1);
    verifyNever(
      () => mockAuthManager.signIn(
        authenticationToken: accessToken,
        refreshAuthenticationToken: refreshToken,
        expiresIn: expiresIn,
        authUid: userId,
      ),
    );
    verifyNever(() => mockAnalytics.setUserId(id: userId));
  });
}
