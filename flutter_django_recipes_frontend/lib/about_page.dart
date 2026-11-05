import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,247, 241, 230),
      appBar: AppBar(
        title: const Text('About Taste AI'),
        backgroundColor: Color.fromARGB(255,247, 241, 230),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Thank you for choosing Taste AI — your intelligent companion for discovering personalized, delicious recipes tailored to your unique preferences.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'We truly appreciate your support. Every dish you create with Taste AI inspires us to enhance your experience through the power of AI.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you have any questions, feedback, or need assistance, feel free to reach out using the contact details below.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            const Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.email, color: Colors.deepOrange),
                SizedBox(width: 10),
                Text('support@tasteai.app'),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.phone, color: Colors.deepOrange),
                SizedBox(width: 10),
                Text('+1 (555) 123-4567'),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.web, color: Colors.deepOrange),
                SizedBox(width: 10),
                Text('www.tasteai.app'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}