class Reminder {
  final String text;
  final String reference;

  Reminder({
    required this.text,
    required this.reference,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        text: json["text"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "reference": reference,
      };
}
