List<Cards> cardsFromJson(List<dynamic> list) =>
    List<Cards>.from(list.map((x) => Cards.fromJson(x)));

class Cards {
  Cards({
    this.id,
    required this.row,
    this.seqNum,
    required this.text,
  });

  int? id;
  String row;
  int? seqNum;
  String text;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        id: json["id"],
        row: json["row"],
        seqNum: json["seq_num"],
        text: json["text"],
      );
}
