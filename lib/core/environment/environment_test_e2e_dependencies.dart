import 'package:get_it/get_it.dart';

class EnvironmentTestE2EDependencies {
  const EnvironmentTestE2EDependencies({
    required this.overrideCoreRegister,
  });

  final Function(GetIt getIt) overrideCoreRegister;
}
