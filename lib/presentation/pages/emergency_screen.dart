import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/calming_animation.dart';
import 'package:country_picker/country_picker.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher_string.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  String _selectedCountryCode = 'US';
  String _selectedCountryName = 'United States';
  Map<String, dynamic> _hotlines = {};
  bool _loadingHotlines = true;

  @override
  void initState() {
    super.initState();
    _loadHotlines();
  }

  Future<void> _loadHotlines() async {
    final data = await rootBundle.loadString('assets/hotlines.json');
    setState(() {
      _hotlines = json.decode(data);
      _loadingHotlines = false;
    });
  }

  Map<String, dynamic>? get _currentHotlines => _hotlines[_selectedCountryCode];

  void _pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _selectedCountryCode = country.countryCode;
          _selectedCountryName = country.name;
        });
      },
    );
  }

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
        child: _loadingHotlines
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
        // Move country picker here
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Country: ', style: TextStyle(fontSize: width * 0.04, color: AppConstants.textPrimaryColor)),
            TextButton.icon(
              onPressed: _pickCountry,
              icon: const Icon(Icons.public),
              label: Text(_selectedCountryName, style: TextStyle(fontSize: width * 0.04)),
            ),
          ],
        ),
        SizedBox(height: height * 0.01),
        if (_currentHotlines != null) ...[
          _buildHotlineCard(
            width,
            icon: Icons.phone,
            label: 'Suicide Prevention Lifeline',
            number: _currentHotlines!['suicide'],
            onTap: () => _makePhoneCall('tel:${_currentHotlines!['suicide']}'),
          ),
          SizedBox(height: height * 0.01),
          _buildHotlineCard(
            width,
            icon: Icons.local_hospital,
            label: 'Emergency Services',
            number: _currentHotlines!['emergency'],
            onTap: () => _makePhoneCall('tel:${_currentHotlines!['emergency']}'),
          ),
        ],
        // Show message if no local hotlines are found
        if (_currentHotlines == null) ...[
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.01),
            child: Text(
              'No local hotlines found for your country. Please use the international resource below.',
              style: TextStyle(
                color: Colors.red[800],
                fontWeight: FontWeight.w600,
                fontSize: width * 0.038,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        // Always show international help card after local hotlines
        Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: height * 0.018, horizontal: width * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppConstants.primaryColor, width: 1.2),
              borderRadius: BorderRadius.circular(width * 0.02),
            ),
            child: Column(
              children: [
                Text(
                  'Find crisis help in your country',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 84, 146, 190),
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.045,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.005),
                InkWell(
                  onTap: () => _launchUrl('https://findahelpline.com/'),
                  child: Text(
                    'findahelpline.com',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 84, 146, 190),
                      fontSize: width * 0.035,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
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

  Widget _buildHotlineCard(double width, {required IconData icon, required String label, required String number, required VoidCallback onTap}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppConstants.primaryColor),
        title: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04)),
        subtitle: Text(number, style: TextStyle(fontSize: width * 0.04)),
        trailing: Icon(Icons.call, color: AppConstants.accentColor),
        onTap: onTap,
      ),
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

  Future<void> _launchUrl(String url) async {
  try {
    final success = await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
    if (!success) {
      debugPrint('Could not launch URL: $url');
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');
  }
}

} 