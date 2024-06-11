
import 'package:flutter/material.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:machine/presentation/colors.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColors.footerBackground,
        padding: const EdgeInsets.all(20),
        child: MediaQuery.sizeOf(context).width > 1280
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildfooter())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildfooter()));
  }

  _buildfooter() {
    return [
      const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "О нас",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 500,
              child: Text(
                "'Точность, надежность, процветание!' — это девиз нашей компании, которая специализируется на поставках запчастей для автомобилей иностранных марок. Мы обслуживаем как оптовых, так и розничных клиентов, предлагая широкий ассортимент продукции. Наличие собственного склада и розничного магазина гарантирует быстрое и комфортное обслуживание каждого клиента.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.ac_unit_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 500,
            height: 220,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Как менеджер нашего магазина, я всегда готов помочь клиентам подобрать нужные запчасти, используя наш обширный каталог и экспертные знания.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.access_alarm_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Менеджер по продажам",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "В ДЕТАЛЯХ",
                              style: TextStyle(color: Colors.white30),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Как консультант, я всегда на связи, чтобы ответить на любые вопросы клиентов и помочь им с выбором, используя свой подход к каждому покупателю.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.access_alarm_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Консультант",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "В ДЕТАЛЯХ",
                              style: TextStyle(color: Colors.white30),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ),
          PageViewIndicator(
            length: 2,
            currentIndex: _currentIndex,
            currentSize: 10,
            currentColor: Colors.blue,
          ),
        ],
      )
    ];
  }
}
