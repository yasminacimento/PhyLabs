import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../subjects/data/subject_catalog.dart';
import '../../subjects/domain/physics_subject.dart';
import '../../subjects/presentation/subject_lessons_screen.dart';
import '../../subjects/presentation/subjects_screen.dart';

enum _HomePage {
  welcome,
  subjects,
  videos,
  activities,
  profile,
  settings,
  about,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/inicio';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomePage _page = _HomePage.welcome;
  PhysicsSubject? _selectedSubject;
  int _selectedTab = 0;

  void _selectPage(_HomePage page) {
    Navigator.of(context).maybePop();
    setState(() {
      if (page == _HomePage.subjects && _page != _HomePage.subjects) {
        _selectedSubject = null;
      }
      _page = page;
    });
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
      _page = switch (index) {
        0 => _HomePage.welcome,
        1 => _HomePage.subjects,
        _ => _HomePage.activities,
      };
      if (index == 1) _selectedSubject = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final name =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'Estudante';

    return Scaffold(
      appBar: AppBar(
        title: const Text('PhyLabs'),
        actions: [
          IconButton(
            tooltip: 'Meu perfil',
            onPressed: () => setState(() => _page = _HomePage.profile),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: AppColors.deepBlue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/phylabs_icon_transparente.png',
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'PhyLabs',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              _drawerItem('Início', Icons.home_outlined, _HomePage.welcome),
              _drawerItem(
                'Matérias',
                Icons.science_outlined,
                _HomePage.subjects,
              ),
              _drawerItem(
                'Videoaulas',
                Icons.play_circle_outline,
                _HomePage.videos,
              ),
              _drawerItem(
                'Atividades',
                Icons.assignment_outlined,
                _HomePage.activities,
              ),
              const Divider(),
              _drawerItem(
                'Meu perfil',
                Icons.person_outline,
                _HomePage.profile,
              ),
              _drawerItem(
                'Configurações',
                Icons.settings_outlined,
                _HomePage.settings,
              ),
              _drawerItem('Sobre', Icons.info_outline, _HomePage.about),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: switch (_page) {
          _HomePage.welcome => _WelcomePage(
            key: const ValueKey(_HomePage.welcome),
            name: name,
            onOpenVideos: () => _selectPage(_HomePage.videos),
            onOpenActivities: () => _selectPage(_HomePage.activities),
          ),
          _HomePage.subjects =>
            _selectedSubject == null
                ? SubjectsScreen(
                    key: const ValueKey('subjects-list'),
                    subjects: physicsSubjects,
                    onSelectSubject: (subject) =>
                        setState(() => _selectedSubject = subject),
                  )
                : SubjectLessonsScreen(
                    key: ValueKey(_selectedSubject!.name),
                    subject: _selectedSubject!,
                    onBack: () => setState(() => _selectedSubject = null),
                  ),
          _HomePage.videos => const _PlaceholderPage(
            key: ValueKey(_HomePage.videos),
            title: 'Videoaulas',
            subtitle: 'Suas aulas e vídeos recentes aparecerão aqui.',
            icon: Icons.play_circle_outline,
          ),
          _HomePage.activities => const _PlaceholderPage(
            key: ValueKey(_HomePage.activities),
            title: 'Atividades',
            subtitle: 'Suas atividades e exercícios aparecerão aqui.',
            icon: Icons.assignment_outlined,
          ),
          _HomePage.profile => _PlaceholderPage(
            key: const ValueKey(_HomePage.profile),
            title: 'Meu perfil',
            subtitle: name,
            icon: Icons.account_circle_outlined,
          ),
          _HomePage.settings => const _PlaceholderPage(
            key: ValueKey(_HomePage.settings),
            title: 'Configurações',
            subtitle: 'Preferências da sua conta.',
            icon: Icons.settings_outlined,
          ),
          _HomePage.about => const _PlaceholderPage(
            key: ValueKey(_HomePage.about),
            title: 'Sobre o PhyLabs',
            subtitle: 'Aprenda física explorando novas possibilidades.',
            icon: Icons.info_outline,
          ),
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.science_outlined),
            selectedIcon: Icon(Icons.science),
            label: 'Matérias',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Atividades',
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(String label, IconData icon, _HomePage page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: _page == page,
      onTap: () => _selectPage(page),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({
    required this.name,
    required this.onOpenVideos,
    required this.onOpenActivities,
    super.key,
  });

  final String name;
  final VoidCallback onOpenVideos;
  final VoidCallback onOpenActivities;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, $name',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Pronto para descobrir algo novo hoje?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.deepBlue,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.blue.withValues(alpha: 0.45),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Seu progresso',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '8',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '  de 24 conteúdos concluídos',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const LinearProgressIndicator(
                      value: 8 / 24,
                      minHeight: 8,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      backgroundColor: AppColors.navy,
                      color: AppColors.gold,
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      '33% da trilha disponível',
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Continuar de onde parou?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              _ContinueTile(
                iconPath: 'assets/images/icon_cinematica.png',
                title: 'Movimento e gráficos',
                subtitle: 'Videoaula  ·  Cinemática',
                actionLabel: 'Continuar vídeo',
                onTap: onOpenVideos,
              ),
              const SizedBox(height: 10),
              _ContinueTile(
                iconPath: 'assets/images/icon_dinamica.png',
                title: 'Leis de Newton',
                subtitle: 'Atividade  ·  Dinâmica',
                actionLabel: 'Retomar atividade',
                onTap: onOpenActivities,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueTile extends StatelessWidget {
  const _ContinueTile({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.field,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.blue.withValues(alpha: 0.28)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Image.asset(iconPath, height: 46, width: 46),
        title: Text(title, style: const TextStyle(color: AppColors.text)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward, color: AppColors.gold),
        onTap: onTap,
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 54, color: AppColors.gold),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
