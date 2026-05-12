import 'package:base_app_clean_arch/presenter/modules/auth_module.dart';
import 'package:base_app_clean_arch/presenter/modules/support_module.dart';
import 'package:get_it/get_it.dart';
import 'core_module.dart';
import 'i_dependence_module.dart';
import 'start_app_module.dart';

class InjectDependenceService implements IDependenceModule {
  static final InjectDependenceService _instance =
      InjectDependenceService._internal();
  InjectDependenceService._internal();
  factory InjectDependenceService() => _instance;

  final getIt = GetIt.instance;

  @override
  void registerDependencies({Function(GetIt getIt)? overrideCoreRegister}) {
    _registerCoreDependencies(overrideCoreRegister: overrideCoreRegister);
    _registerDependenciesThatCanRecreated();
  }

  void _registerCoreDependencies({
    Function(GetIt getIt)? overrideCoreRegister,
  }) {
    getIt.pushNewScope(
      scopeName: 'CoreScope',
      init: (getIt) {
        CoreModule().registerDependencies();
        if (overrideCoreRegister != null) {
          overrideCoreRegister(getIt);
        }
      },
    );
  }

  void _registerDependenciesThatCanRecreated() {
    getIt.pushNewScope(
      scopeName: 'ScopeThatCanRecreated',
      init: (getIt) {
        AuthModule().registerDependencies();
        StartAppModule().registerDependencies();
        SupportModule().registerDependencies();
      },
    );
  }

  Future<void> recreateDependences() async {
    await getIt.popScopesTill('ScopeThatCanRecreated');
    _registerDependenciesThatCanRecreated();
  }
}
