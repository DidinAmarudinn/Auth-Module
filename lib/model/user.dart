part of 'models.dart';

class User extends Equatable {
  User(
      {this.status,
      this.message,
      this.userId,
      this.name,
      this.image,
      this.token});

  final int? status;
  final String? message;
  final int? userId;
  final String? name;
  final String? image;
  final String? token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        userId: json["userId"],
        name: json["name"],
        image: json["image"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "userId": userId,
        "name": name,
        "image": image,
        "token": token,
      };

  @override
  List<Object?> get props => [status ?? "", message ?? "", name, image, token];
}
