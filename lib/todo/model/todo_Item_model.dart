class TodoItemModel {
  final String id;
  String title;
  String subTitle;
  // CompletionStatus status;
  TodoType type;
  // 完成进度(0~1)
  double progress;

  get status{
    switch (progress) {
      case 0:
        return CompletionStatus.notCompleted;
      case 1:
        return CompletionStatus.completed;
      default:
        return CompletionStatus.progressing;
    }
  }

  TodoItemModel(
      {required this.id,
      required this.title,
      this.subTitle = "",
      this.type = TodoType.noSet,
      this.progress = 0})
      : assert(progress >= 0 && progress <= 1);
}

class CategoriesModel {
  final TodoType type;
  final String categoryName;

  CategoriesModel(this.type, this.categoryName);
}

class CompletionStatusModel {
  final CompletionStatus status;
  final String statusName;

  CompletionStatusModel(this.status, this.statusName);
}

enum CompletionStatus { completed, notCompleted, progressing }

enum TodoType {
  noSet,
  work,
  life,
  learn,
}
