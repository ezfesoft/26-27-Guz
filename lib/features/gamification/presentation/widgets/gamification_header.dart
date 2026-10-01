import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_theme.dart';
import '../providers/gamification_provider.dart';

class GamificationHeader extends ConsumerWidget {
  const GamificationHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 20,
        vertical: isMobile ? 8 : 10,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.deepNavy,
        border: Border(
          bottom: BorderSide(color: AppTheme.turquoise, width: 2),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Streak Item (Fire 🔥)
            _MetricItem(
              icon: Icons.local_fire_department_rounded,
              iconColor: AppTheme.amberGold,
              label: '${state.streak}',
              tooltip: 'Günlük Seri',
              isMobile: isMobile,
            ),
            // Gems Item (Diamond 💎)
            _MetricItem(
              icon: Icons.diamond_rounded,
              iconColor: AppTheme.turquoise,
              label: '${state.gems}',
              tooltip: 'Elmas Bakiyesi',
              isMobile: isMobile,
            ),
            // Hearts Item (Hearts ❤️)
            _MetricItem(
              icon: Icons.favorite_rounded,
              iconColor: state.hearts > 0 ? AppTheme.roseRed : const Color(0xFF64748B),
              label: '${state.hearts}/${state.maxHearts}',
              tooltip: 'Can Hakkı',
              isMobile: isMobile,
            ),
            // XP Item (Star ⭐)
            _MetricItem(
              icon: Icons.star_rounded,
              iconColor: AppTheme.amberGold,
              label: '${state.xp} XP',
              tooltip: 'Toplam Puan',
              isMobile: isMobile,
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String tooltip;
  final bool isMobile;

  const _MetricItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.tooltip,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 12,
          vertical: isMobile ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: AppTheme.darkSlate,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: iconColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: isMobile ? 18 : 22),
            SizedBox(width: isMobile ? 4 : 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: isMobile ? 13 : 15,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
