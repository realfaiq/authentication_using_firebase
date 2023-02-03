class Admin {
  final String aId;
  final String fullName;
  final String email;
  final String age;

  const Admin({
    required this.aId,
    required this.fullName,
    required this.email,
    required this.age,
  });

  Map<String, dynamic> toJSON() => {
        "aId": aId,
        "fullName": fullName,
        "email": email,
        "age": age,
      };
}
