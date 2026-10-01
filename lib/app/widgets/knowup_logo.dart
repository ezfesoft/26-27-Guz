import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class KnowUpLogo extends StatelessWidget {
  final double logoSize;
  final bool showSlogan;
  final bool isDarkBackground;
  final bool useSvgBrand;
  final CrossAxisAlignment alignment;

  const KnowUpLogo({
    super.key,
    this.logoSize = 44,
    this.showSlogan = true,
    this.isDarkBackground = false,
    this.useSvgBrand = false,
    this.alignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    if (useSvgBrand) {
      final svgAsset = isDarkBackground
          ? 'assets/branding/knowup_logo_dark.svg'
          : 'assets/branding/knowup_logo.svg';

      return SvgPicture.asset(
        svgAsset,
        height: logoSize * 1.8,
        fit: BoxFit.contain,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // KnowUp Logo Icon Container with smooth shadow & turquoise accent border
            Container(
              width: logoSize,
              height: logoSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(logoSize * 0.28),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.turquoise.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(logoSize * 0.28),
                child: Image.asset(
                  'assets/icon.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/icons/knowup_icon.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            // KnowUp Brand Title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: logoSize * 0.52,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'Know',
                        style: TextStyle(
                          color: isDarkBackground ? Colors.white : AppTheme.deepNavy,
                        ),
                      ),
                      const TextSpan(
                        text: 'Up',
                        style: TextStyle(
                          color: AppTheme.turquoise,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showSlogan) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Öğren. Pekiştir. Ustalaş.',
                    style: GoogleFonts.inter(
                      fontSize: logoSize * 0.24,
                      fontWeight: FontWeight.w600,
                      color: isDarkBackground
                          ? AppTheme.turquoiseLight.withValues(alpha: 0.85)
                          : const Color(0xFF64748B),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }
}
