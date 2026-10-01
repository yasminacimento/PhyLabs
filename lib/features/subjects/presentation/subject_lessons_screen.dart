import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../domain/physics_subject.dart';

class SubjectLessonsScreen extends StatelessWidget {
  const SubjectLessonsScreen({
    required this.subject,
    required this.onBack,
    super.key,
  });

  final PhysicsSubject subject;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Todas as matérias'),
                  style: TextButton.styleFrom(foregroundColor: AppColors.gold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset(subject.iconAsset, width: 54, height: 54),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        subject.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Aulas disponíveis',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 18),
                ...subject.lessons.indexed.map((entry) {
                  final (index, lesson) = entry;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: AppColors.field,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: AppColors.blue.withValues(alpha: 0.28),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.deepBlue,
                          foregroundColor: AppColors.gold,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(
                          'Aula ${index + 1} - $lesson',
                          style: const TextStyle(color: AppColors.text),
                        ),
                        trailing: const Icon(
                          Icons.play_circle_outline,
                          color: AppColors.gold,
                        ),
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'O conteúdo desta aula será adicionado em breve.',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
