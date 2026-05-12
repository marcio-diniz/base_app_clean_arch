enum SupportSubjectEnum {
  problem,
  noActiveVehicles,
  deleteAccount,
  other;

  String get subjectText {
    switch (this) {
      case SupportSubjectEnum.problem:
        return 'Tive um problema';
      case SupportSubjectEnum.noActiveVehicles:
        return 'Não tenho veículos ativos';
      case SupportSubjectEnum.deleteAccount:
        return 'Quero excluir minha conta';
      case SupportSubjectEnum.other:
        return 'Outro...';
    }
  }
}
