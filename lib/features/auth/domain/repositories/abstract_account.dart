abstract class AbstractAccount {
  final int id;
  final bool isDeleted;
  final String accountStatus;
  final bool verified;
  final List<String> roles;

  AbstractAccount({
    required this.id,
    required this.isDeleted,
    required this.accountStatus,
    required this.verified,
    required this.roles,
  });
}
