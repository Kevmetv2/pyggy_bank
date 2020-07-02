class Cards {
  String card_number;
  String cardholder;
  String ccv;
  String expiration;

  Cards({this.cardholder, this.card_number, this.ccv, this.expiration});

  Map toMap(Cards card) {
    var data = Map<String, dynamic>();
    data['cardNumber'] = card.card_number;
    data['cardholder'] = card.cardholder;
    data['ccv'] = card.ccv;
    data['expiration'] = card.expiration;

    return data;
  }

  Cards.fromMap(Map<String, dynamic> mapData) {
    this.expiration = mapData['expiration'];
    this.ccv = mapData['ccv'];
    this.cardholder = mapData['cardholder'];
    this.card_number = mapData['card_number'];
  }
}
