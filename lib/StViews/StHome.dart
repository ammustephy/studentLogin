import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:student/StProvider/StAuthentication_Provider.dart';
import 'package:student/StProvider/StNews_Provider.dart';
import 'package:student/StViews/StNotifications.dart';
import 'package:student/StViews/StProfile.dart';
import 'package:student/StViews/StSettings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final _pageWidgets = <Widget>[
    const HomeContent(),
    const NotificationsPage(),
    const SettingsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int idx) {
    setState(() => _selectedIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final student = auth.studentId ?? 'Student';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text(
          'Hi, $student',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            // fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,size: 20,),
            color: Colors.white,
            onPressed: auth.logout,
          ),
        ],
      ),
      body: _pageWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  static final features = [
    _FeatureCard('Attendance', 'assets/images/attendances.png', '/attendance'),
    _FeatureCard('Notifications', 'assets/images/notification.png', '/notifications'),
    _FeatureCard('Exam Results', 'assets/images/ExamResult.png', '/exam_results'),
    _FeatureCard('Marklist', 'assets/images/Marklist.png', '/marklist'),
    _FeatureCard('Syllabus', 'assets/images/book.png', '/syllabus'),
    _FeatureCard('Notes', 'assets/images/Notes.png', '/notes'),
    _FeatureCard('Online Classroom', 'assets/images/OnlineClass.png', '/online_classroom'),
    _FeatureCard('Bus', 'assets/images/SchoolBus.png', '/bus'),
    _FeatureCard('Payments', 'assets/images/OnlinePayments.png', '/payments'),
  ];

  @override
  Widget build(BuildContext context) {
    final news = context.watch<NewsProvider>().news;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // 📢 News carousel
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CarouselSlider.builder(
                itemCount: news.length,
                itemBuilder: (ctx, idx, real) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade200.withOpacity(0.8),
                        Colors.indigo.shade100.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                    news[idx],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.indigo.shade900, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                options: CarouselOptions(
                  height: 150,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                  autoPlayInterval: const Duration(seconds: 4),
                  scrollPhysics: BouncingScrollPhysics(),
                ),
              ),
            ),

            // 🔲 Animated Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: AnimationLimiter(
                  child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    padding: const EdgeInsets.only(bottom: 16),
                    children: List.generate(features.length, (i) {
                      final f = features[i];
                      return AnimationConfiguration.staggeredGrid(
                        position: i,
                        columnCount: 3,
                        duration: const Duration(milliseconds: 400),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(context, f.routeName),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))
                                  ],
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        f.iconAsset,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) =>
                                            Icon(Icons.school, size: 20, color: Colors.indigo.shade700),
                                        height: 40,width: 45,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      f.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.indigo.shade700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard {
  final String title;
  final String iconAsset;
  final String routeName;
  const _FeatureCard(this.title, this.iconAsset, this.routeName);
}
