enum ButtonStatus {
  active,
  loading,
  disabled;

  bool get isLoading => this == loading;
  bool get isDisabled => this == disabled;
  bool get isActive => this == active;
}
