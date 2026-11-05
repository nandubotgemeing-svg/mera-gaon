import 'package:flutter/material.dart';

void main() => runApp(const MeraGaonApp());

const green = Color(0xFF16834A);
const darkGreen = Color(0xFF0D5D35);
const paleGreen = Color(0xFFEAF6EE);

class MeraGaonApp extends StatelessWidget {
  const MeraGaonApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'MERA GAON',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: green), scaffoldBackgroundColor: const Color(0xFFF7FAF7)),
    home: const MainShell(),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;
  final List<Map<String, String>> submittedPosts = [];
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onOpen: (i) => setState(() => selected = i)),
      const SimplePage(title: 'गाँव की खबरें', subtitle: 'स्थानीय खबरें जाँच के बाद यहाँ दिखाई जाएँगी।', icon: Icons.newspaper),
      const SimplePage(title: 'गाँव का बाजार', subtitle: 'स्थानीय सामान और सेवाएँ जल्द उपलब्ध होंगी।', icon: Icons.storefront),
      const SimplePage(title: 'नौकरी और काम', subtitle: 'सत्यापित रोजगार के अवसर जल्द उपलब्ध होंगे।', icon: Icons.work_outline),
      ProfilePage(postCount: submittedPosts.length),
    ];
    return Scaffold(
      body: SafeArea(child: pages[selected]),
      floatingActionButton: selected == 0 || selected == 1 ? FloatingActionButton.extended(
        backgroundColor: green, foregroundColor: Colors.white, icon: const Icon(Icons.add), label: const Text('पोस्ट करें'),
        onPressed: () async {
          final post = await Navigator.push<Map<String, String>>(context, MaterialPageRoute(builder: (_) => const CreatePostPage()));
          if (post != null) setState(() => submittedPosts.add(post));
        },
      ) : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected, onDestinationSelected: (v) => setState(() => selected = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'होम'),
          NavigationDestination(icon: Icon(Icons.newspaper_outlined), label: 'खबरें'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'बाजार'),
          NavigationDestination(icon: Icon(Icons.work_outline), label: 'नौकरी'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'प्रोफाइल'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ValueChanged<int> onOpen;
  const HomePage({super.key, required this.onOpen});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(18, 16, 18, 90), children: [
    Row(children: [
      Container(width: 48, height: 48, decoration: BoxDecoration(color: paleGreen, borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.grass, color: green, size: 30)),
      const SizedBox(width: 10),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('MERA GAON', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: darkGreen)),
        Text('अपना गाँव, अपनी पहचान', style: TextStyle(color: Colors.black54, fontSize: 12)),
      ])),
      const Icon(Icons.notifications_none, color: darkGreen, size: 28),
    ]),
    const SizedBox(height: 20),
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [green, darkGreen]), borderRadius: BorderRadius.circular(22)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('नमस्ते! आपका स्वागत है 👋', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
        SizedBox(height: 7), Text('बस्तर की खबरें, काम और बाजार — सब एक जगह।', style: TextStyle(color: Colors.white, height: 1.4)),
        SizedBox(height: 13), Row(children: [Icon(Icons.location_on, color: Colors.white70, size: 17), SizedBox(width: 5), Text('बस्तर, छत्तीसगढ़', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))]),
      ])),
    const SizedBox(height: 22),
    const Text('आपके लिए सेवाएँ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen)),
    const SizedBox(height: 12),
    GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.55, children: [
      ServiceTile(icon: Icons.newspaper, title: 'गाँव की खबरें', subtitle: 'स्थानीय अपडेट', onTap: () => onOpen(1)),
      ServiceTile(icon: Icons.storefront, title: 'गाँव का बाजार', subtitle: 'खरीदें और बेचें', onTap: () => onOpen(2)),
      ServiceTile(icon: Icons.work, title: 'नौकरी और काम', subtitle: 'रोजगार खोजें', onTap: () => onOpen(3)),
      ServiceTile(icon: Icons.campaign, title: 'जरूरी सूचना', subtitle: 'घोषणाएँ और कार्यक्रम', onTap: () => onOpen(1)),
    ]),
    const SizedBox(height: 22),
    const Text('ताज़ा अपडेट', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen)),
    const SizedBox(height: 10),
    const InfoCard(icon: Icons.info_outline, title: 'MERA GAON में आपका स्वागत है', body: 'यह शुरुआती डेमो है। वास्तविक खबरें और पोस्ट Admin की जाँच के बाद जोड़ी जाएँगी।'),
    const SizedBox(height: 9),
    const InfoCard(icon: Icons.verified_user_outlined, title: 'सुरक्षित पोस्टिंग', body: 'यूजर की भेजी पोस्ट समीक्षा के बाद ही सार्वजनिक की जाएगी।'),
  ]);
}

class ServiceTile extends StatelessWidget {
  final IconData icon; final String title; final String subtitle; final VoidCallback onTap;
  const ServiceTile({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18),
    child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE2EDE5))),
      child: Row(children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: paleGreen, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: green)),
        const SizedBox(width: 9),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: darkGreen)),
          const SizedBox(height: 3), Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.black54)),
        ])),
      ])),
  );
}

class InfoCard extends StatelessWidget {
  final IconData icon; final String title; final String body;
  const InfoCard({super.key, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE4ECE6))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: green), const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.black54, height: 1.4, fontSize: 12)),
      ])),
    ]),
  );
}

class SimplePage extends StatelessWidget {
  final String title; final String subtitle; final IconData icon;
  const SimplePage({super.key, required this.title, required this.subtitle, required this.icon});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
    const SizedBox(height: 14), InfoCard(icon: icon, title: title, body: subtitle),
  ]);
}

class ProfilePage extends StatelessWidget {
  final int postCount;
  const ProfilePage({super.key, required this.postCount});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('आपकी प्रोफाइल', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
    const SizedBox(height: 22),
    const CircleAvatar(radius: 38, backgroundColor: paleGreen, child: Icon(Icons.person, size: 42, color: green)),
    const SizedBox(height: 10),
    const Center(child: Text('अतिथि यूजर', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
    const Center(child: Text('डेमो मोड', style: TextStyle(color: Colors.black54, fontSize: 12))),
    const SizedBox(height: 20),
    InfoCard(icon: Icons.pending_actions, title: 'भेजी गई पोस्ट', body: '$postCount पोस्ट इस ऐप से भेजी गई हैं। अभी ये केवल डेमो में गिनी जाती हैं।'),
    const SizedBox(height: 10),
    const ListTile(leading: Icon(Icons.language, color: green), title: Text('भाषा'), subtitle: Text('भाषा चयन अगले चरण में जोड़ा जाएगा')),
    const ListTile(leading: Icon(Icons.login, color: green), title: Text('Login'), subtitle: Text('OTP और Google Login अगले चरण में जोड़े जाएँगे')),
  ]);
}

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});
  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}
class _CreatePostPageState extends State<CreatePostPage> {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  String category = 'गाँव की खबर';
  @override
  void dispose() { titleController.dispose(); detailsController.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('नई पोस्ट')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('अपनी जानकारी भेजें', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkGreen)),
      const SizedBox(height: 6),
      const Text('यह डेमो है। पोस्ट अभी सर्वर पर नहीं जाती और सार्वजनिक नहीं होती।', style: TextStyle(color: Colors.black54, height: 1.4)),
      const SizedBox(height: 18),
      DropdownButtonFormField<String>(value: category, decoration: const InputDecoration(labelText: 'पोस्ट का प्रकार'), items: const [
        DropdownMenuItem(value: 'गाँव की खबर', child: Text('गाँव की खबर')),
        DropdownMenuItem(value: 'नौकरी', child: Text('नौकरी')),
        DropdownMenuItem(value: 'बाजार', child: Text('बाजार')),
        DropdownMenuItem(value: 'कार्यक्रम / सूचना', child: Text('कार्यक्रम / सूचना')),
      ], onChanged: (v) => setState(() => category = v ?? category)),
      const SizedBox(height: 12),
      TextField(controller: titleController, decoration: const InputDecoration(labelText: 'शीर्षक')),
      const SizedBox(height: 12),
      TextField(controller: detailsController, minLines: 4, maxLines: 7, decoration: const InputDecoration(labelText: 'पूरी जानकारी')),
      const SizedBox(height: 20),
      FilledButton.icon(style: FilledButton.styleFrom(backgroundColor: green, padding: const EdgeInsets.symmetric(vertical: 15)),
        onPressed: () {
          if (titleController.text.trim().isEmpty || detailsController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('कृपया शीर्षक और जानकारी भरें।')));
            return;
          }
          Navigator.pop(context, {'category': category, 'title': titleController.text.trim(), 'details': detailsController.text.trim(), 'status': 'pending'});
        },
        icon: const Icon(Icons.send), label: const Text('जाँच के लिए भेजें')),
    ]),
  );
}
