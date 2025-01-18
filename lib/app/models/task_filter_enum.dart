enum TaskFilterEnum {
  today,
  tomorrow,
  week,
  // month,
  // all,
}

extension TaskFilterTitle on TaskFilterEnum {
  String get period {
    switch (this) {
      case TaskFilterEnum.today:
        return 'DE HOJE';
      case TaskFilterEnum.tomorrow:
        return 'DE AMANHÃ';
      case TaskFilterEnum.week:
        return 'DA SEMANA';
    }
  }
}
