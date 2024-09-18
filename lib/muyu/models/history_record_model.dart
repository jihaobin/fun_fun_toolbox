class HistoryRecordModel {
  final String id;
  final int timestamp;
  final int value;
  final String image;
  final String audio;

  HistoryRecordModel(
      {required this.id,
      required this.timestamp,
      required this.value,
      required this.image,
      required this.audio});
}
