import 'package:flutter/material.dart';
import 'package:flutterbase/components/curve_appbar.dart';
import 'package:flutterbase/screens/bill/pre_listing.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class MenuBillScreen extends StatefulWidget {
  final Map from;
  const MenuBillScreen({Key? key, required this.from}) : super(key: key);

  @override
  State<MenuBillScreen> createState() => _MenuBillScreenState();
}

@override
class _MenuBillScreenState extends State<MenuBillScreen> {
  bool _isLoading = false;
  final List<Map> myProducts =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();
  late Map from = {};

  @override
  void initState() {
    super.initState();
    initPage();
  }

  initPage() async {
    setState(() {
      from = widget.from;
    });

    print("from MenuBill " + from.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: CurveAppBar(
        title: "Servis Perkhidmatan",
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: constants.primaryColor,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            var homeRoute = MaterialPageRoute(builder: (_) => MenuScreen());
            Navigator.of(context)
                .pushAndRemoveUntil(homeRoute, (route) => false);
          },
          icon: Icon(
            LineIcons.times,
            color: constants.primaryColor,
            size: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Tajuk Servis Perkhidmatan",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Title",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: styles.inputDecoration.copyWith(
                labelText: 'Carian',
                prefixIcon: LineIcon(Icons.search),
              ),
            ),
          ),
          _isLoading == true
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 1.7),
                    child: DefaultLoadingBar(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 500,
                    width: 500,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      itemCount: myProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => {
                            print(index.toString()),
                            navigate(
                                context,
                                PreListingScreen(
                                  from: from,
                                ))
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/dist/submenu_icon.png',
                                  width: 65,
                                  height: 65,
                                ),
                                Text(
                                  myProducts[index]['id'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
