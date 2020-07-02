class card_bank {
  String cardholder;
  String card_number;
  String ccv;
  String expiration;

  card_bank({
    this.cardholder,
    this.card_number,
    this.ccv,
    this.expiration,
  });

  Map toMap(card_bank card) {
    var data = Map<String, dynamic>();
    data['card_number'] = card.card_number;
    data['cardholder'] = card.cardholder;
    data['expriation'] = card.expiration;
    data['ccv'] = card.ccv;
    return data;
  }

  card_bank.fromMap(Map<String, dynamic> mapData) {
    this.card_number = mapData['card_number'];
    this.cardholder = mapData['cardholder'];
    this.expiration = mapData['expiration'];
    this.ccv = mapData['ccv'];
  }
}
