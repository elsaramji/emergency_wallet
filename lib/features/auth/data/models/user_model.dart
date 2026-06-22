import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> rootData, Map<String, dynamic> profileData) {
    final String firstName = profileData['firstName'] as String? ?? '';
    final String lastName = profileData['lastName'] as String? ?? '';
    final String fullName = firstName.isNotEmpty || lastName.isNotEmpty 
        ? '$firstName $lastName'.trim() 
        : rootData['email']?.split('@').first ?? 'User';

    return UserModel(
      id: rootData['uid'] as String? ?? '',
      name: profileData['favoriteName'] as String? ?? fullName,
      email: rootData['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toRootFirestore(String provider) {
    return {
      'uid': id,
      'email': email,
      'provider': provider,
    };
  }

  Map<String, dynamic> toProfileFirestore(String firstName, String lastName) {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
