enum LoadStatusEnum {
  initial,
  loading,
  success,
  failed;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailed => this == failed;
  bool get isLoadingOrInitial => isLoading || isInitial;
  bool get isInitialOrFailed => isInitial || isFailed;
}
