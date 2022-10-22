import 'package:flutter/material.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/components/popupmenu.dart';
import 'package:seatwashing/view/adminDateAdd.dart';
import 'package:seatwashing/view/adress_to_go_page.dart';
import 'package:seatwashing/view/date_page.dart';
import 'package:seatwashing/view/date_request_page.dart';
import 'package:seatwashing/view/user_requests_page.dart';
import 'package:seatwashing/view/users_page.dart';
import 'package:seatwashing/viewmodels/dateManegement.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: kPrimaryColor,
                  floating: true,
                  title: const Text('Yönetim Paneli'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminDateAdd()),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DateManagementPage()),
                          );
                        },
                        icon: const Icon(Icons.edit_calendar_sharp))
                  ],
                )
              ];
            },
            body: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: 'GİDİLECEK ADRESLER'),
                    Tab(text: 'RANDEVU İSTEKLERİ'),
                    Tab(text: 'KULLANICILAR'),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        AddressToGo(),
                        DateRequestPage(),
                        UserPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData? icon;
  final Function? routePage;

  const MenuItem({required this.text, this.icon, this.routePage});
}

class MenuItems {
  static List<MenuItem> firsItems = [
    itemDateRequest,
    itemUserRequest,
    itemAdress,
    itemUser
  ];
  static const List<MenuItem> secondItems = [itemLogout];
  static const itemDateRequest =
      MenuItem(text: 'Randevu İstekleri', icon: Icons.app_registration);
  static const itemUserRequest =
      MenuItem(text: 'Kullanıcı İstekleri', icon: Icons.request_page);
  static const itemAdress =
      MenuItem(text: 'Gidilecek Adresler', icon: Icons.house_siding_outlined);
  static const itemUser =
      MenuItem(text: 'Müşteriler', icon: Icons.supervised_user_circle);

  static const itemLogout = MenuItem(text: 'Çıkış Yap', icon: Icons.logout);
}
