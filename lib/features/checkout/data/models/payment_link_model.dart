class PaymentLinkModel {
  final String link;
  final String reference;
  final String payCode;

  const PaymentLinkModel({
    required this.link,
    required this.reference,
    required this.payCode,
  });

  factory PaymentLinkModel.fromJson(Map<String, dynamic> json) {
    return PaymentLinkModel(
      link: json['link'],
      reference: json['reference'],
      payCode: json['payCode'],
    );
  }
}
