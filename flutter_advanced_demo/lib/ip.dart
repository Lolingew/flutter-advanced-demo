class Ip {
  final String origin;

  Ip(this.origin);

  Ip.fromJson(Map<String, dynamic> json)
    : origin = json['origin']; //还可以加别的参数等式，用逗号隔开

  Map<String, dynamic> toJson() => {
    'origin': origin
  };
}