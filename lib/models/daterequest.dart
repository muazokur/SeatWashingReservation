class DateRequest {
  final String? userId;
  final String? userName;
  final String? userSurName;
  final String? userPhoneNumber;
  final String? userAddress;
  final String? date;
  final String? dateDay;
  final bool? requestStatus;

  DateRequest({
    this.userId,
    this.userName,
    this.userSurName,
    this.userPhoneNumber,
    this.userAddress,
    this.date,
    this.dateDay,
    this.requestStatus,
  });

  //objeden map oluşturma
  ///MAP idler firebase ile aynı olmalıdır
  Map<String, dynamic> toMap() => {
        'userId': userId,
        'name': userName,
        'surname': userSurName,
        'address': userAddress,
        'phoneNumber': userPhoneNumber,
        'date': date,
        'day': dateDay,
        'requestStatus': requestStatus,
      };

  //mapten obje oluşturma
  factory DateRequest.fromMap(Map map) => DateRequest(
        userId: map['userId'],
        userName: map['name'],
        userSurName: map['surname'],
        userPhoneNumber: map['phoneNumber'],
        userAddress: map['address'],
        date: map['date'],
        dateDay: map['day'],
        requestStatus: map['requestStatus'],
      );
}
