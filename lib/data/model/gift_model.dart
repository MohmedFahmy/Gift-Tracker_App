class Gift {
  final String name;
  final String description;
  final String recipient;
  final DateTime? eventDate;
  final String? eventName;

  Gift({
    required this.name,
    required this.description,
    required this.recipient,
    this.eventDate,
    this.eventName,
  });
}
