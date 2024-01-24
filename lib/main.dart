import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tech_blog/Model/Currency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // farsi
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'dana',
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              titleMedium: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
              bodyMedium: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
              bodySmall: TextStyle(
                  fontFamily: 'dana',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.red),
              bodyLarge: TextStyle(
                  fontFamily: "dana",
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.green))),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext cntx) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";

    var value = await http.get(Uri.parse(url));

    ///  developer.log(value.body, name: "getresponse");

    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        developer.log("statuscode", error: value.statusCode);
        _showSnackBar(context, "به روز رسانی با موفقیت انجام شد");
        // developer.log(
        //   "amirkoho",
        //   error: convert.jsonDecode(value.body),
        //   name: "body",
        // );
        List jsonList = convert.jsonDecode(value.body);
        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    getResponse(context);
    developer.log("initstate", name: "wlife");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    developer.log("didChangeDependencies", name: "wlife");
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    developer.log("didUpdateWidget", name: "wlife");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    developer.log("dispose", name: "wlife");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    developer.log("deactivate", name: "wlife");
  }

  @override
  Widget build(BuildContext context) {
    developer.log("build", name: "wlife");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          const SizedBox(
            width: 8,
          ),
          Image.asset("assets/images/icon.png"),
          Align(
              alignment: Alignment.centerRight,
              child: Text("قیمت به روز ارز",
                  style: Theme.of(context).textTheme.titleLarge)),
          Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/images/menu.png"))),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/question.png"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "نرخ ارز آزاد چیست؟",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Text(
                        " نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.",
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1200),
                          color: Color.fromARGB(255, 130, 130, 130)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "نام ارز آزاد",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "قیمت",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "تغییر",
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      child: listfuturebuilder(context))
                ],
              )

              ///textboutten
              ,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1500),
                        color: Color.fromARGB(255, 232, 232, 232)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            child: TextButton.icon(
                                onPressed: () {
                                  currency.clear();
                                  listfuturebuilder(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.refresh_bold,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  "به روز رسانی",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 202, 193, 255),
                                    ),
                                    shape: MaterialStatePropertyAll<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1000))))),
                          ),
                          Text("آخرین به روز رسانی: ${_gettime()}"),
                          const SizedBox(
                            width: 0,
                          )
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listfuturebuilder(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int postion) {
                  return MyItem(postion, currency);
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 8 == 0) {
                    return Add();
                  } else {
                    return SizedBox.shrink();
                  }
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
      future: getResponse(context),
    );
  }
}

String _gettime() {
  return DateFormat("hh:mm:ss").format(DateTime.now());
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    backgroundColor: Colors.green,
  ));
}

class MyItem extends StatelessWidget {
  int postion;
  List<Currency> currency;
  MyItem(this.postion, this.currency);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 1.5, color: Colors.grey)
        ], color: Colors.white, borderRadius: BorderRadius.circular(1500)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${currency[postion].title}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              fanumber(currency[postion].price.toString()),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              fanumber(currency[postion].changes.toString()),
              style: currency[postion].status == "p"
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

String fanumber(String number) {
  const fa = ['۰', '١', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  const en = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];

  for (var element in en) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  }
  return number;
}

class Add extends StatelessWidget {
  const Add({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 1.5, color: Colors.grey)
        ], color: Colors.red, borderRadius: BorderRadius.circular(1500)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "تبلیغات",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
