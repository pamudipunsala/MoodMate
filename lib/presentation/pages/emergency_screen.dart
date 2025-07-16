import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/calming_animation.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calm & Support'),
        backgroundColor: AppConstants.surfaceColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          child: Column(
            children: [
              _buildCalmingSection(),
              const SizedBox(height: AppConstants.spacingXL),
              _buildAffirmationsSection(),
              const SizedBox(height: AppConstants.spacingXL),
              _buildEmergencyResourcesSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalmingSection() {
    return Column(
      children: [
        Text(
          'Take a moment to breathe',
          style: TextStyle(
            fontSize: AppConstants.fontSizeXLarge,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingL),
        const CalmingAnimation(),
      ],
    );
  }

  Widget _buildAffirmationsSection() {
    final affirmations = [
      'You are not alone in this.',
      'Your feelings are valid and temporary.',
      'You have the strength to get through this.',
      'It\'s okay to ask for help.',
      'You are worthy of love and support.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Positive Affirmations',
          style: TextStyle(
            fontSize: AppConstants.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.spacingM),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          decoration: BoxDecoration(
            color: AppConstants.secondaryColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
            boxShadow: AppConstants.softShadow,
          ),
          child: Column(
            children: affirmations.map((affirmation) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.spacingM),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 16,
                      color: AppConstants.accentColor,
                    ),
                    const SizedBox(width: AppConstants.spacingS),
                    Expanded(
                      child: Text(
                        affirmation,
                        style: TextStyle(
                          fontSize: AppConstants.fontSizeMedium,
                          color: AppConstants.textPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyResourcesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get Help',
          style: TextStyle(
            fontSize: AppConstants.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.spacingM),
        _buildEmergencyCard(
          context,
          title: 'National Suicide Prevention Lifeline',
          subtitle: 'Call ${AppConstants.emergencyHotline}',
          icon: Icons.phone,
          color: AppConstants.errorColor,
          onTap: () => _callEmergencyHotline(context),
        ),
        const SizedBox(height: AppConstants.spacingM),
        _buildEmergencyCard(
          context,
          title: 'Crisis Text Line',
          subtitle: AppConstants.emergencyText,
          icon: Icons.message,
          color: AppConstants.warningColor,
          onTap: () => _openCrisisTextLine(context),
        ),
        const SizedBox(height: AppConstants.spacingM),
        _buildEmergencyCard(
          context,
          title: 'Emergency Services',
          subtitle: 'Call 911 if you\'re in immediate danger',
          icon: Icons.emergency,
          color: AppConstants.errorColor,
          onTap: () => _callEmergencyServices(context),
        ),
        const SizedBox(height: AppConstants.spacingL),
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          decoration: BoxDecoration(
            color: AppConstants.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            border: Border.all(
              color: AppConstants.primaryColor.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppConstants.primaryColor,
                size: 24,
              ),
              const SizedBox(width: AppConstants.spacingS),
              Expanded(
                child: Text(
                  'Remember: You are not alone. There are people who care about you and want to help.',
                  style: TextStyle(
                    fontSize: AppConstants.fontSizeSmall,
                    color: AppConstants.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        decoration: BoxDecoration(
          color: AppConstants.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          boxShadow: AppConstants.softShadow,
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: AppConstants.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppConstants.fontSizeMedium,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: AppConstants.fontSizeSmall,
                      color: AppConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppConstants.textSecondaryColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _callEmergencyHotline(BuildContext context) {
    _showConfirmationDialog(
      context,
      title: 'Call Suicide Prevention Lifeline',
      content: 'This will call ${AppConstants.emergencyHotline}. Are you sure?',
      onConfirm: () {
        _makePhoneCall('tel:${AppConstants.emergencyHotline}');
      },
    );
  }

  void _openCrisisTextLine(BuildContext context) {
    _showConfirmationDialog(
      context,
      title: 'Open Crisis Text Line',
      content: 'This will open your messaging app to text HOME to 741741. Are you sure?',
      onConfirm: () {
        _sendSMS('741741', 'HOME');
      },
    );
  }

  void _callEmergencyServices(BuildContext context) {
    _showConfirmationDialog(
      context,
      title: 'Call Emergency Services',
      content: 'This will call 911. Only use this if you are in immediate danger. Are you sure?',
      onConfirm: () {
        _makePhoneCall('tel:911');
      },
    );
  }

  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch phone call';
      }
    } catch (e) {
      // Fallback: copy to clipboard
      await Clipboard.setData(ClipboardData(text: phoneNumber));
      // Note: context is not available in this async method
      // User will see the copied number in clipboard
    }
  }

  Future<void> _sendSMS(String phoneNumber, String message) async {
    try {
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: {'body': message},
      );
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        throw 'Could not launch SMS';
      }
    } catch (e) {
      // Fallback: copy to clipboard
      await Clipboard.setData(ClipboardData(text: 'Text HOME to $phoneNumber'));
      // Note: context is not available in this async method
      // User will see the copied instructions in clipboard
    }
  }
} 