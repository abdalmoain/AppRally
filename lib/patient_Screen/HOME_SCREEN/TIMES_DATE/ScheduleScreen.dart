import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<dynamic> agents = [];
  String name = "https://52244135896d.ngrok-free.app" ;// هون بنخزن أسماء السفراء

  @override
  void initState() {
    super.initState();
    fetchAgents(); // أول ما تفتح الصفحة رح نجيب السفراء
  }

  // دالة تجيب بيانات السفراء من API
  Future<void> fetchAgents() async {
    final response = await http.get(
      Uri.parse(name+"/api/v1/patients/listAgents"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        agents = data; // لازم يكون response عبارة عن List من السفراء
      });
    } else {
      throw Exception("فشل في جلب السفراء");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "مواعيدي",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),

      // ✅ الجسم
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // شريط الأيام
          SizedBox(
            height: height * 0.1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildDayItem("الأحد", "17", false, width),
                buildDayItem("الاثنين", "18", false, width),
                buildDayItem("الثلاثاء", "19", true, width),
                buildDayItem("الأربعاء", "20", false, width),
                buildDayItem("الخميس", "21", false, width),
                buildDayItem("الجمعة", "22", false, width),
              ],
            ),
          ),

          const SizedBox(height: 10),
          Divider(height: 1, color: Colors.grey.shade400),
          const SizedBox(height: 16),

          // ✅ هون عرض السفراء بدل البطاقات الثابتة
          agents.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: agents.map((agent) {
                    return buildScheduleCard(
                      start_time: "٨:٣٠ ص",
                      Safeer_name: agent["name"] ?? "بدون اسم", // الاسم من API
                      room: "قاعة B3",
                      teacher: "أ. أحمد",
                      color: Colors.white,
                      width: width,
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  // عنصر اليوم
  Widget buildDayItem(String day, String date, bool isSelected, double width) {
    return Container(
      width: width * 0.22,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.deepPurple : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.04,
                color: isSelected ? Colors.white : Colors.black,
              )),
          const SizedBox(height: 4),
          Text(date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.045,
                color: isSelected ? Colors.white : Colors.black,
              )),
        ],
      ),
    );
  }

  // بطاقة الحصة
  Widget buildScheduleCard({
    required String start_time,
    required String Safeer_name,
    required String room,
    required String teacher,
    required Color color,
    required double width,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.access_time, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(start_time,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.04)),
                const SizedBox(height: 8),
                Text(Safeer_name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.05)),
                const SizedBox(height: 4),
                Text(room,
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: width * 0.04)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage("assets/images/doctor.png"),
                    ),
                    const SizedBox(width: 8),
                    Text(teacher,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.04)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
