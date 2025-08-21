import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SAFEER_SELECTION extends StatefulWidget {
  final int agentId; // معرف السفير
  const SAFEER_SELECTION({super.key, required this.agentId, required String token});

  @override
  State<SAFEER_SELECTION> createState() => _SAFEER_SELECTIONState();
}

class _SAFEER_SELECTIONState extends State<SAFEER_SELECTION> {
  double rating = 4.5; // تقييم افتراضي
  String aboutMe = 'أؤمن أن العطاء مسؤولية، وأن كل جهد صغير قادر على إحداث فرق كبير'; // النبذة سيتم جلبها من API

  Future<Map<String, dynamic>> fetchAgentData() async {
    final response = await http.get(
      Uri.parse(
          'https://ce7decf716a3.ngrok-free.app/api/v1/agents/${widget.agentId}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return data;
    } else {
      throw Exception('فشل في جلب بيانات السفير');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchAgentData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('لا توجد بيانات'));
            }

            final agent = snapshot.data!;
            final name = agent['base_user']['first_name'];
            final lastName = agent['base_user']['last_name'];
            final location = agent['location'] ?? 'غير محدد';
            final phone = agent['base_user']['phone_number'] ?? 'غير متوفر';
            aboutMe = agent['about_me'] ?? aboutMe;
            rating = double.tryParse(agent['rating']?.toString() ?? '') ?? rating;

            // قائمة الأوقات المتاحة القادمة من API
            final availableSlots = agent['available_slots'] as List<dynamic>? ?? [];

            return Column(
              children: [
                const SizedBox(height: 24),
                // صورة البروفايل
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.deepPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: agent['profile_image'] != null
                        ? NetworkImage(agent['profile_image'])
                        : const AssetImage('assets/images/pic3.png')
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                // الاسم
                Text(
                  ' الدكتور $name $lastName',
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'سفير عيادة ',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                ),
                const SizedBox(height: 30),

                // الإحصائيات مع التقييم
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn(agent['cases_diagnosed']?.toString() ?? '0',
                          'الحالات المشخصة'),
                      const VerticalDivider(
                        color: Colors.deepPurple,
                        width: 20,
                        thickness: 1,
                      ),
                      _buildRatingColumn(rating, 'التقييم'),
                      const VerticalDivider(
                        color: Colors.deepPurple,
                        width: 20,
                        thickness: 1,
                      ),
                      _buildStatColumn(agent['lessons_count']?.toString() ?? '0',
                          'الدروس'),
                    ],
                  ),
                ),

                // المحتوى الأساسي
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          // قسم النبذة
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Text(
                                    'نبذة ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  aboutMe,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                          // موقع ورقم الهاتف
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.deepPurple, width: 1),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "الموقع : $location",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  leading: const Icon(Icons.location_on,
                                      size: 18, color: Colors.deepPurple),
                                ),
                                const SizedBox(height: 8),
                                ListTile(
                                  title: Text(
                                    "للتواصل : $phone",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  leading: const Icon(Icons.phone,
                                      size: 18, color: Colors.deepPurple),
                                )
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "الأوقات المتاحة للاستشارة",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // عرض الأوقات القادمة من API بصيغة day + start_time + end_time
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: availableSlots.map((slot) {
                              final day = slot['day'] ?? '';
                              final startTime = slot['start_time'] ?? '';
                              final endTime = slot['end_time'] ?? '';
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "$day من $startTime إلى $endTime",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "احجز موعد",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: Colors.deepPurple, fontSize: 14)),
      ],
    );
  }

  Widget _buildRatingColumn(double rating, String label) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < fullStars; i++)
              const Icon(Icons.star, color: Colors.amber, size: 20),
            if (halfStar)
              const Icon(Icons.star_half, color: Colors.amber, size: 20),
            for (int i = 0;
                i < (5 - fullStars - (halfStar ? 1 : 0));
                i++)
              const Icon(Icons.star_border, color: Colors.amber, size: 20),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$rating',
          style: const TextStyle(color: Colors.deepPurple, fontSize: 14),
        ),
      ],
    ); 
  }
}
