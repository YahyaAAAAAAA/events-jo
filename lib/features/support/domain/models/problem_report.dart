class ProblemReport {
  final String id;
  final String problem;
  final String userId;
  final String userName;
  final bool isDone;

  ProblemReport({
    required this.id,
    required this.problem,
    required this.userId,
    required this.userName,
    required this.isDone,
  });

  static ProblemReport fromJson(Map<String, dynamic> json) {
    return ProblemReport(
      id: json['id'] as String,
      problem: json['problem'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'problem': problem,
      'userId': userId,
      'userName': userName,
      'isDone': isDone,
    };
  }
}
