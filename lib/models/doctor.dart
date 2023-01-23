class Doctor {
  final String name;
  final String uid;
  final String specialization;
  final String profilePic;
  final int enrolled;

  Doctor({
    required this.profilePic,
    required this.name,
    required this.uid,
    required this.specialization,
    required this.enrolled,
  });

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      specialization: map['spec'] ?? '',
      enrolled: map['enrolled'] ?? 0,
    );
  }
}
