import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fd),
      // bottomSheet: Container(
      //   padding: const EdgeInsets.all(20),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: <Widget>[
      //       IconButton(
      //         icon: const Icon(
      //           Icons.subscriptions,
      //           color: Color(0xff2657ce),
      //           size: 40,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(
      //           Icons.account_circle,
      //           color: const Color(0xff2657ce).withOpacity(0.5),
      //           size: 40,
      //         ),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
     
      body: Container(
        padding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Hello Learners",
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/image/profilePic.png'))),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'How can we help \nyou Today?',
                style: TextStyle(
                    fontSize: 35, height: 1.3, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        courseWidget(
                            'Preperation',
                            'Study Abroad',
                            'Consulancy regarding studying abraod\n Your Personal statement,\n research proposals,\n IELTS preps',
                            'img1',
                            const Color(0xffff6a65),
                            const Color(0xffff5954)),
                        const SizedBox(
                          height: 20,
                        ),
                        courseWidget(
                            'Research',
                            'Masters and PhD',
                            'Consultancy in successful completion of research Projects for Masters and PhD students',
                            'img2',
                            const Color(0xffe9eefa),
                            Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        courseWidget(
                            'Home Work',
                            'Bachelors and Masters',
                            'Consultancy in successfully completing home work for Bachelor and Master students',
                            'img3',
                            const Color(0xffe9eefa),
                            Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                        courseWidget(
                            'Skills',
                            'CV Writing',
                            'Consultancy in drafting CV, writing reports, developing writing skills, data analysis',
                            'img4',
                            const Color(0xffbdcddf),
                            const Color(0xffcedaff)),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container courseWidget(String category, String title, String details,
      String img, Color categoryColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: () {
          openCoursePage(img, title, details);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                category,
                style: TextStyle(
                    color: (categoryColor == const Color(0xffe9eefa)
                        ? const Color(0xff2657ce)
                        : Colors.white)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: (bgColor == const Color(0xffff5954))
                    ? Colors.white
                    : Colors.black,
                fontSize: 20,
                height: 1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 5,
                  width: 100,
                  color: (bgColor == const Color(0xffff5954))
                      ? Colors.red
                      : const Color(0xff2657ce),
                ),
                Expanded(
                  child: Container(
                    height: 5,
                    color: (bgColor == const Color(0xffff5954))
                        ? Colors.white.withOpacity(0.5)
                        : const Color(0xff2657ce).withOpacity(0.5),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Hero(
              tag: img,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/image/$img.png'),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openCoursePage(String img, String title, String details) {
    Navigator.pushNamed(context, '/coursePage',
        arguments: {'img': img, 'title': title, 'details': details});
  }
}
