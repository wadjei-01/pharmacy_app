class RegisteredBusiness {
  final String id;
  final String name;
  final String imagePath;
  final String businessType;
  final String ownerName;
  final String ownerPhoneNo;
  final String email;
  final String country;
  final String address;
  final String createdOn;
  final String buukingsTotalCount;
  final String buukingsPaidCount;
  final String servicesTotal;
  RegisteredBusiness({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.businessType,
    required this.ownerName,
    required this.ownerPhoneNo,
    required this.email,
    required this.country,
    required this.address,
    required this.createdOn,
    required this.buukingsTotalCount,
    required this.buukingsPaidCount,
    required this.servicesTotal,
  });
}
