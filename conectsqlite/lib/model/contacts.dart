class Customer {
  int? id;
  String name;
  String phone;
  String email;
  String user;
  String pass;

  Customer(
      {this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.user,
      required this.pass});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        user: json['user'],
        pass: json['pass'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'user': user,
        'pass': pass,
      };
}
