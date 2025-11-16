import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final String languageCode;
  const AboutPage({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            languageCode == 'bn' ? 'ক্যাস কাউন্টার নির্দেশনা' : 'Cash Counter Instructions',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- About Section ---
              Text(
                languageCode == 'bn' ? 'অ্যাপ সম্পর্কে' : 'About App',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                languageCode == 'bn'
                    ? 'ক্যাস কাউন্টার অ্যাপটি ব্যবহার করে আপনি সহজে এবং দ্রুত টাকার পরিমাণ গণনা করতে পারবেন। এটি বিশেষভাবে ব্যাঙ্ক, দোকান, বা ব্যক্তিগত হিসাবের জন্য ডিজাইন করা হয়েছে।'
                    : 'The Cash Counter app allows you to quickly and easily calculate cash totals. It is designed for banks, shops, or personal accounting.',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),

              // --- How to Use Section ---
              Text(
                languageCode == 'bn' ? 'কিভাবে ব্যবহার করবেন' : 'How to Use',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                languageCode == 'bn'
                    ? '• “টাকা” এবং “সংখ্যা” ফিল্ডে তথ্য লিখুন।\n• প্রতিটি সারির মোট স্বয়ংক্রিয়ভাবে গণনা হবে।\n• সব সারির মোট টাকার হিসাব নিচে দেখানো হবে।\n• নতুন সারি যোগ করতে নিচের “যোগ করুন” বাটনে ক্লিক করুন।\n• কোনো সারি মুছে দিতে X আইকনে ক্লিক করুন।'
                    : '• Enter the "Amount" and "Qty" in each row.\n• Total per row is calculated automatically.\n• Total cash is shown at the bottom.\n• Click "Add New" to add a new row.\n• Click the X icon to remove a row.',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),

              // --- Disclaimer Section ---
              Text(
                languageCode == 'bn' ? 'দায়বদ্ধতা' : 'Disclaimer',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                languageCode == 'bn'
                    ? '• এই অ্যাপটি শুধুমাত্র হিসাবের সুবিধার জন্য তৈরি।\n• টাকার হিসাবের জন্য এটি আনুষ্ঠানিক বা লাইসেন্সকৃত সফটওয়্যার নয়।\n• ব্যবহারকারীর ভুল ইনপুটের জন্য অ্যাপ দায়িত্ব গ্রহণ করে না।\n• দয়া করে বড় বা গুরুত্বপূর্ণ হিসাবের জন্য নিশ্চিত থাকুন এবং যাচাই করুন।'
                    : '• This app is intended for convenience in counting cash only.\n• It is not an official or licensed financial software.\n• The app is not responsible for errors due to user input.\n• Please verify important or large calculations manually.',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),

              // --- Footer / Note ---
              Text(
                languageCode == 'bn' ? 'দ্রষ্টব্য' : 'Note',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                languageCode == 'bn'
                    ? 'আপনি চাইলে ভাষা পরিবর্তন করে বাংলা বা ইংরেজি ব্যবহার করতে পারেন। সব হিসাব স্বয়ংক্রিয়ভাবে আপডেট হয়।'
                    : 'You can switch the language between Bangla and English. All calculations are updated automatically.',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}