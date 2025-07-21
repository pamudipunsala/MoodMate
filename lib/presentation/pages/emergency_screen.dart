import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/calming_animation.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Resources',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.textPrimaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              _buildCalmingSection(width, height),
              SizedBox(height: height * 0.03),
              _buildAffirmationsSection(width, height),
              SizedBox(height: height * 0.03),
              _buildEmergencyResourcesSection(context, width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalmingSection(double width, double height) {
    return Column(
      children: [
        Text(
          'Take a moment to breathe',
          style: TextStyle(
            fontSize: width * 0.06,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.02),
        CalmingAnimation(
          heartColor: const Color.fromARGB(255, 154, 27, 126), // Deep purple
          circleColor: const Color(0xFF8E24AA).withOpacity(0.3), // Visible purple
        ),
      ],
    );
  }

  Widget _buildAffirmationsSection(double width, double height) {
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
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        SizedBox(height: height * 0.015),
        Container(
          padding: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            color: Color(0xFFF3E6F9), // very light pastel purple
            borderRadius: BorderRadius.circular(width * 0.04),
            boxShadow: AppConstants.softShadow,
          ),
          child: Column(
            children: affirmations.map((affirmation) {
              return Padding(
                padding: EdgeInsets.only(bottom: height * 0.015),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // <-- Center vertically
                  children: [
                    Icon(
                      Icons.favorite,
                      size: width * 0.04,
                      color: const Color.fromARGB(197, 187, 36, 86),
                    ),
                    SizedBox(width: width * 0.02), // Less space between icon and text
                    Expanded(
                      child: Text(
                        affirmation,
                        style: TextStyle(
                          fontSize: width * 0.04,
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

  Widget _buildEmergencyResourcesSection(BuildContext context, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get Help',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        SizedBox(height: height * 0.015),
        _buildEmergencyCard(
          context,
          title: 'National Suicide Prevention Lifeline',
          subtitle: 'Call ${AppConstants.emergencyHotline}',
          icon: Icons.phone,
          color: AppConstants.errorColor,
          onTap: () => _callEmergencyHotline(context),
          width: width,
          height: height,
        ),
        SizedBox(height: height * 0.015),
        // _buildEmergencyCard(
        //   context,
        //   title: 'Crisis Text Line',
        //   subtitle: AppConstants.emergencyText,
        //   icon: Icons.message,
        //   color: AppConstants.warningColor,
        //   onTap: () => _openCrisisTextLine(context),
        //   width: width,
        //   height: height,
        // ),
        SizedBox(height: height * 0.015),
        _buildEmergencyCard(
          context,
          title: 'Emergency Services',
          subtitle: 'Call 119 if you\'re in immediate danger',
          icon: Icons.emergency,
          color: AppConstants.errorColor,
          onTap: () => _callEmergencyServices(context),
          width: width,
          height: height,
        ),
        SizedBox(height: height * 0.02),
        Container(
          padding: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            color: Color(0xFFE6F4EA), // very light pastel green
            borderRadius: BorderRadius.circular(width * 0.02),
            border: Border.all(
              color: AppConstants.primaryColor.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppConstants.primaryColor,
                size: width * 0.06,
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Text(
                  'Remember: You are not alone. There are people who care about you and want to help.',
                  style: TextStyle(
                    fontSize: width * 0.035,
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
    required double width,
    required double height,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: AppConstants.surfaceColor,
          borderRadius: BorderRadius.circular(width * 0.02),
          boxShadow: AppConstants.softShadow,
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(width * 0.02),
              ),
              child: Icon(
                icon,
                color: color,
                size: width * 0.06,
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: AppConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppConstants.textSecondaryColor,
              size: width * 0.04,
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
      content: 'This will call 119. Only use this if you are in immediate danger. Are you sure?',
      onConfirm: () {
        _makePhoneCall('tel:119');
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