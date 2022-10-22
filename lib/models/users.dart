class Users {
  final String? userId;
  final String? userName;
  final String? userSurName;
  final String? userPhoneNumber;
  final String? userAddress;
  final bool? requestStatus;

  Users({
    this.userId,
    this.userName,
    this.userSurName,
    this.userPhoneNumber,
    this.userAddress,
    this.requestStatus,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'name': userName,
        'surname': userSurName,
        'address': userAddress,
        'phoneNumber': userPhoneNumber,
        'requestStatus': requestStatus,
      };

  //mapten obje oluşturma
  factory Users.fromMap(Map map) => Users(
        userId: map['userId'],
        userName: map['name'],
        userSurName: map['surname'],
        userPhoneNumber: map['phoneNumber'],
        userAddress: map['address'],
        requestStatus: map['requestStatus'],
      );
}

class UsersToGo {
  final String? userId;
  final String? userName;
  final String? userSurName;
  final String? userPhoneNumber;
  final String? userAddress;
  final bool? requestStatus;
  final String? date;
  final String? day;

  UsersToGo({
    this.userId,
    this.userName,
    this.userSurName,
    this.userPhoneNumber,
    this.userAddress,
    this.requestStatus,
    this.date,
    this.day,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'name': userName,
        'surname': userSurName,
        'address': userAddress,
        'phoneNumber': userPhoneNumber,
        'requestStatus': requestStatus,
        'date': date,
        'day': day,
      };

  //mapten obje oluşturma
  factory UsersToGo.fromMap(Map map) => UsersToGo(
      userId: map['userId'],
      userName: map['name'],
      userSurName: map['surname'],
      userPhoneNumber: map['phoneNumber'],
      userAddress: map['address'],
      requestStatus: map['requestStatus'],
      date: map['date'],
      day: map['day']);
}

class UsersAttempt {
  static List<String> names = [
    'Mahmut Yıldırım',
    'Mehmet Korkmaz',
    'Hasan Demir',
    'Kemal Tanca',
  ];
  static List<String> phones = [
    '0537 042 23 12',
    '0535 034 47 34',
    '0532 852 10 34',
    '0534 246 23 43',
  ];
  static List<String> address = [
    'Bosna Hersek Mahallesi Eseköşk Sitesi B Blokpopopooposna Hersek Mahallesi Eseköşk Sitesi B Blokpopopoop',
    'Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya',
    'Kosova Mahallesi Tuğba Sitesi A Blok No/2 Selçuklu/Konya',
    'Kosova Mahallesi Mercan Sitesi A Blok No/2 Selçuklu/Konya',
  ];
  static List<String> date = [
    '11-02-2022',
    '12-02-2022',
    '12-02-2022',
    '13-02-2022',
  ];
  static List<String> time = ['21:30', '20:10', '15:30', '14:10'];
}

class Users2 {
  static List<Map<String, String>> kisiBilgileri = [];
  //Onaylanan randevular
  Users2() {
    Map<String, String> kisiBilgileri1 = {};
    kisiBilgileri1["names"] = "Mahmut Yıldırım";
    kisiBilgileri1["phones"] = "0534 246 23 43";
    kisiBilgileri1["address"] =
        "Kosova Mahallesi Tuğba Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri1["date"] = "11-02-2022";

    Map<String, String> kisiBilgileri2 = {};
    kisiBilgileri2["names"] = "Cemal Tanca";
    kisiBilgileri2["phones"] = "0532 852 10 34";
    kisiBilgileri2["address"] =
        "Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri2["date"] = "20-02-2022";

    Map<String, String> kisiBilgileri3 = {};
    kisiBilgileri3["names"] = "Ahmet Tanca";
    kisiBilgileri3["phones"] = "0532 852 10 34";
    kisiBilgileri3["address"] =
        "Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri3["date"] = "20-02-2022";

    Map<String, String> kisiBilgileri4 = {};
    kisiBilgileri4["names"] = "Mesut Tanca";
    kisiBilgileri4["phones"] = "0532 852 10 34";
    kisiBilgileri4["address"] =
        "Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri4["date"] = "21-02-2022";

    Map<String, String> kisiBilgileri5 = {};
    kisiBilgileri5["names"] = "Selvi Boylu";
    kisiBilgileri5["phones"] = "0532 852 10 34";
    kisiBilgileri5["address"] =
        "Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri5["date"] = "22-02-2022";

    Map<String, String> kisiBilgileri6 = {};
    kisiBilgileri6["names"] = "Ayşe Baş";
    kisiBilgileri6["phones"] = "0532 852 10 34";
    kisiBilgileri6["address"] =
        "Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri6["date"] = "22-02-2022";

    Map<String, String> kisiBilgileri7 = {};
    kisiBilgileri7["names"] = "Hasan Taş";
    kisiBilgileri7["phones"] = "0532 852 10 34";
    kisiBilgileri7["address"] =
        "Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri7["date"] = "24-02-2022";

    Map<String, String> kisiBilgileri8 = {};
    kisiBilgileri8["names"] = "Fatih Aş";
    kisiBilgileri8["phones"] = "0532 852 10 34";
    kisiBilgileri8["address"] =
        "Bosna Hersek Mahallesi Dilruba Sitesi A Blok Hersek Mahallesi Eseköşk Sitesi A Blok No/2 Selçuklu/Konya";
    kisiBilgileri8["date"] = "02-02-2022";

    // kisiBilgileri.add(kisiBilgileri1);
    // kisiBilgileri.add(kisiBilgileri2);
    // kisiBilgileri.add(kisiBilgileri3);
    // kisiBilgileri.add(kisiBilgileri4);
    // kisiBilgileri.add(kisiBilgileri5);
    // kisiBilgileri.add(kisiBilgileri6);
    // kisiBilgileri.add(kisiBilgileri7);
    // kisiBilgileri.add(kisiBilgileri8);

    //kisiBilgileri.clear();
  }

  static List<Map<String, String>> kisiGoster() {
    return kisiBilgileri;
  }
}
