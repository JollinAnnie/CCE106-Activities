class Usercomment {
  final String commenterImg;
  final String commenterName;
  final String commenterTime;
  final String commenterContent;

  Usercomment({
    required this.commenterImg,
    required this.commenterName,
    required this.commenterTime,
    required this.commenterContent,
  });

  Map<String, String> toJson() => {
    'commenterImg': commenterImg,
    'commenterName': commenterName,
    'commenterTime': commenterTime,
    'commenterContent': commenterContent,
  };

  factory Usercomment.fromJson(Map<String, dynamic> json) => Usercomment(
    commenterImg: json['commenterImg'] as String,
    commenterName: json['commenterName'] as String,
    commenterTime: json['commenterTime'] as String,
    commenterContent: json['commenterContent'] as String,
  );
}
