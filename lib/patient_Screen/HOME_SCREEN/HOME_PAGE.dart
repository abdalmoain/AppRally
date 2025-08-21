import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/patient_Screen/HOME_SCREEN/7ALAT/Safeer.dart';

class HOME_SCREEN extends StatelessWidget {
  const HOME_SCREEN({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEFE7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //شرييييييط البحث خوييي
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications, color: Colors.deepPurple),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: CircleAvatar(backgroundColor: Colors.deepPurple),
                        ),
                      ],
                    ),
                    //نص فوق زر البحث
                    Text(
                      "قم بالبحث عن السفير الخاص بك ",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),

                      child: SearchBar(
                        backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                        leading: const Icon(Icons.search,color: Colors.white,),
                        trailing: [Icon(Icons.filter_list,color: Colors.white,)],
                        hintText: "ابحث عن أقرب سفير ",hintStyle: WidgetStateProperty.all(
    TextStyle(color: Colors.white)
                      ),
                    ),
                   )   ],
                ),
              ),

              const SizedBox(height: 15),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 125,
                              height: 125,
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/welcome.png",
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'ابدأ رحلتك العلاجية معنا',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: const Text(
                                    'احجز استشارتك الأولية الآن لتشخيص حالتك والتواصل معك من قبل الأطباء',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 1),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFA084E8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                onPressed: () {  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SafeersScreen()));},
                                  child: const Text(
                                    'احجز موعد',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      ' السفراء  ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.03 ),
                    child: TextButton(
                      onPressed: () {  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SafeersScreen()),
                );},
                      child: Text(
                        "عرض الكل",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 1),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'د. أحمد علي',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'طبيب أسنان',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),
              ReminderSlider(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class ReminderSlider extends StatefulWidget {
  const ReminderSlider({super.key});

  @override
  _ReminderSliderState createState() => _ReminderSliderState();
}

class _ReminderSliderState extends State<ReminderSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/pic10.png',
    },
    {
      'image': 'assets/images/pic9.png',
    },
    {
      'image': 'assets/images/pic8.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < items.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: PageView.builder(
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                items[index]['image']!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover, // تم التعديل هنا
              ),
            ),
          );
        },
      ),
    );
  }
}
