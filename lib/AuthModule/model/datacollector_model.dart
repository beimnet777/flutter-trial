import 'package:flutter_px/AuthModule/model/user_model.dart';

// Gender Enum
enum Gender { male, female, other }

Gender genderFromString(String value) {
  switch (value) {
    case 'M':
      return Gender.male;
    case 'F':
      return Gender.female;
    case 'O':
      return Gender.other;
    default:
      throw Exception('Invalid gender value');
  }
}

// IDType Enum
enum IDType { passport, nationalID, driverLicense }

IDType idTypeFromString(String value) {
  switch (value) {
    case 'passport':
      return IDType.passport;
    case 'national_id':
      return IDType.nationalID;
    case 'driver_license':
      return IDType.driverLicense;
    default:
      throw Exception('Invalid ID type value');
  }
}

// EducationLevel Enum
enum EducationLevel {
  noFormalEducation,
  primary,
  secondary,
  highSchool,
  associateDegree,
  bachelorsDegree,
  mastersDegree,
  doctorate,
  professionalCertificate,
}

EducationLevel educationLevelFromString(String value) {
  switch (value) {
    case 'no_formal_education':
      return EducationLevel.noFormalEducation;
    case 'primary':
      return EducationLevel.primary;
    case 'secondary':
      return EducationLevel.secondary;
    case 'high_school':
      return EducationLevel.highSchool;
    case 'associate_degree':
      return EducationLevel.associateDegree;
    case 'bachelors_degree':
      return EducationLevel.bachelorsDegree;
    case 'masters_degree':
      return EducationLevel.mastersDegree;
    case 'doctorate':
      return EducationLevel.doctorate;
    case 'professional_certificate':
      return EducationLevel.professionalCertificate;
    default:
      throw Exception('Invalid education level value');
  }
}

// Address Model
class Address {
  final String id;
  final String country;
  final String region;
  final String city;
  final String zoneOrSubcity;
  final String woreda;
  final String? postalCode;
  final String addressLine1;
  final String addressLine2;

  Address({
    required this.id,
    required this.country,
    required this.region,
    required this.city,
    required this.zoneOrSubcity,
    required this.woreda,
    this.postalCode,
    required this.addressLine1,
    required this.addressLine2,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      country: json['country'],
      region: json['region'],
      city: json['city'],
      zoneOrSubcity: json['zone_or_subcity'],
      woreda: json['woreda'],
      postalCode: json['postal_code'],
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'region': region,
        'city': city,
        'zone_or_subcity': zoneOrSubcity,
        'woreda': woreda,
        'postal_code': postalCode,
        'address_line_1': addressLine1,
        'address_line_2': addressLine2,
      };
}

// DataCollectorUserProfile Model
class DataCollectorUserProfile {
  final String id;
  final User user;
  final Address userAddress;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String nationality;
  final Gender gender;
  final EducationLevel educationLevel;
  final bool marriageStatus;
  final String emergencyContactName;
  final String emergencyContactNumber;
  final String? credentialImage;
  final String tinNumber;
  final IDType idType;
  final String? idImage;
  final String? idNumber;
  final String? profilePicture;
  final double latitude;
  final double longitude;

  DataCollectorUserProfile({
    required this.id,
    required this.user,
    required this.userAddress,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.nationality,
    required this.gender,
    required this.educationLevel,
    required this.marriageStatus,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
    this.credentialImage,
    required this.tinNumber,
    required this.idType,
    this.idImage,
    this.idNumber,
    this.profilePicture,
    required this.latitude,
    required this.longitude,
  });

  factory DataCollectorUserProfile.fromJson(Map<String, dynamic> json) {
    return DataCollectorUserProfile(
      id: json['id'],
      user: User.fromJson(json['user']),
      userAddress: Address.fromJson(json['user_address']),
      phoneNumber: json['phone_number'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      nationality: json['nationality'],
      gender: genderFromString(json['gender']),
      educationLevel: educationLevelFromString(json['education_level']),
      marriageStatus: json['marriage_status'],
      emergencyContactName: json['emergency_contact_name'],
      emergencyContactNumber: json['emergency_contact_number'],
      credentialImage: json['credential_image'],
      tinNumber: json['tin_number'],
      idType: idTypeFromString(json['id_type']),
      idImage: json['id_image'],
      idNumber: json['id_number'],
      profilePicture: json['profile_picture'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'user_address': userAddress.toJson(),
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth.toIso8601String(),
        'nationality': nationality,
        'gender': gender.name,
        'education_level': educationLevel.name,
        'marriage_status': marriageStatus,
        'emergency_contact_name': emergencyContactName,
        'emergency_contact_number': emergencyContactNumber,
        'credential_image': credentialImage,
        'tin_number': tinNumber,
        'id_type': idType.name,
        'id_image': idImage,
        'id_number': idNumber,
        'profile_picture': profilePicture,
        'latitude': latitude,
        'longitude': longitude,
      };
}
