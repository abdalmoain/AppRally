import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/URLL.dart' as ApiConfig;
import 'package:flutter_application_1/patient_Screen/HOME_SCREEN/Safeer_profile.dart';
import 'package:http/http.dart' as http;
 // استورد صفحة التفاصيل

// نموذج السفير
class Safeer {
  final int id;
  final String firstName;
  final String lastName;
  final String location;
  final String cityName;

  Safeer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.cityName,
  });

  factory Safeer.fromJson(Map<String, dynamic> json) {
    final baseUser = json['base_user'] ?? {};
    final city = json['city'] ?? {};
    return Safeer(
      id: json['id'] ?? 0,
      firstName: baseUser['first_name'] ?? '',
      lastName: baseUser['last_name'] ?? '',
      location: json['location'] ?? '',
      cityName: city['name'] ?? 'بدون مدينة',
    );
  }
}

// بطاقة السفير
class SafeerCard extends StatelessWidget {
  final Safeer safeer;

  const SafeerCard({super.key, required this.safeer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // الانتقال لصفحة تفاصيل السفير
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SAFEER_SELECTION(agentId: safeer.id, token: '',),
          ),
        );
      },
      child: Card(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                '${safeer.firstName} ${safeer.lastName}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// صفحة قائمة السفراء
class SafeersScreen extends StatefulWidget {
  const SafeersScreen({super.key});

  @override
  State<SafeersScreen> createState() => _SafeersScreenState();
}

class _SafeersScreenState extends State<SafeersScreen> {
  late Future<List<Safeer>> _futureSafeers;

  Future<List<Safeer>> fetchSafeers() async {
  final baseUrl = "https://ce7decf716a3.ngrok-free.app/api/v1/patients/listAgents";

    final response = await http.get(Uri.parse(baseUrl                            ));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> agents = body['data']['agents'];
      return agents.map((e) => Safeer.fromJson(e)).toList();
    } else {
      throw Exception("فشل في جلب البيانات: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    _futureSafeers = fetchSafeers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سفراؤنا')),
      body: FutureBuilder<List<Safeer>>(
        future: _futureSafeers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("خطأ: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("لا يوجد سفراء"));
          }

          final safeers = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: safeers.length,
            itemBuilder: (context, index) {
              return SafeerCard(safeer: safeers[index]);
            },
          );
        },
      ),
    );
  }
}
