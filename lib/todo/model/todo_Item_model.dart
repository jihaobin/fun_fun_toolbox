class TodoItemModel {
  final String id;
  final String title;
  final String subTitle;
  final CompletionStatus status;
  final TodoType type;
  // 完成进度(0~1)
  final double progress;

  TodoItemModel(
      {required this.id,
      required this.title,
      this.subTitle = "",
      this.status = CompletionStatus.notCompleted,
      this.type = TodoType.noSet,
      this.progress = 0})
      : assert(progress >= 0 && progress <= 1);
}

enum CompletionStatus { completed, notCompleted, progressing }

enum TodoType {
  noSet,
  work,
  life,
  learn,
}
