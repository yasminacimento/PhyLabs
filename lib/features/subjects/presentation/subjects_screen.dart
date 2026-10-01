import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../domain/physics_subject.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({
    required this.subjects,
    required this.onSelectSubject,
    super.key,
  });

  final List<PhysicsSubject> subjects;
  final ValueChanged<PhysicsSubject> onSelectSubject;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Matérias',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  'Escolha um assunto para explorar as aulas.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                ...subjects.map(
                  (subject) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _SubjectTile(
                      subject: subject,
                      onTap: () => onSelectSubject(subject),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SubjectTile extends StatelessWidget {
  const _SubjectTile({required this.subject, required this.onTap});

  final PhysicsSubject subject;
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
        minVerticalPadding: 12,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Image.asset(
          subject.iconAsset,
          width: 52,
          height: 52,
          fit: BoxFit.contain,
        ),
        title: Text(
          subject.name,
          style: const TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text('${subject.lessons.length} aulas'),
        trailing: const Icon(Icons.chevron_right, color: AppColors.gold),
        onTap: onTap,
      ),
    );
  }
}
