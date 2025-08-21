import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// الخطوة 1: تسجيل الدخول والحصول على التوكن
Future<String?> getToken() async {
  final loginUrl = Uri.parse('https://355c3ff51dfe.ngrok-free.app/api/v1/login');

  try {
    final response = await http.get(
      loginUrl,
      // headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({
      //   'email': 'your@email.com', // 🔁 استبدل بالإيميل الصحيح
      //   'password': 'your_password', // 🔁 استبدل بالباسورد الصحيح
      // }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // 🔁 تأكد إن المفتاح اسمه "token" بالضبط
    } else {
      print('❌ Login failed: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('❌ Login error: $e');
    return null;
  }
}

// الخطوة 2: جلب أسماء الحالات باستخدام التوكن
Future<List<String>> fetchAllConditionNames() async {
  final url = Uri.parse('https://355c3ff51dfe.ngrok-free.app/api/v1/conditions');

  try {
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == true && data['data'] is List) {
        return (data['data'] as List)
            .where((e) => e['name'] != null)
            .map<String>((e) => e['name'] as String)
            .toList();
      } else {
        print('❌ Invalid data structure');
        return [];
      }
    } else if (response.statusCode == 401) {
      print('❌ Unauthorized - maybe token needed?');
      return [];
    } else {
      print('❌ Server error: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('❌ Error: $e');
    return [];
  }
}


// واجهة عرض الحالات
class CasesCard extends StatelessWidget {
  const CasesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("قائمة الحالات")),
      body: FutureBuilder<List<String>>(
        future: fetchAllConditionNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء جلب البيانات'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد حالات متاحة'));
          }

          final conditionNames = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: conditionNames.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 80,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    conditionNames[index],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
