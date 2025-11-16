import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'about_page.dart';

void main() {
  runApp(const MyApp());
}

// Bengali number conversion
String toBengaliNumber(String input) {
  const eng = ['0','1','2','3','4','5','6','7','8','9'];
  const beng = ['০','১','২','৩','৪','৫','৬','৭','৮','৯'];
  for (int i = 0; i < 10; i++) {
    input = input.replaceAll(eng[i], beng[i]);
  }
  return input;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String languageCode = 'en'; // default English

  void changeLanguage(String code) {
    setState(() {
      languageCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('bn'),
      ],
      home: CalculatorPage(
        languageCode: languageCode,
        onLanguageChange: changeLanguage,
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  final String languageCode;
  final void Function(String) onLanguageChange;

  const CalculatorPage({
    super.key,
    required this.languageCode,
    required this.onLanguageChange,
  });

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final List<RowData> rows = [RowData()];

  double get totalSum => rows.fold(0, (sum, r) => sum + r.total);

  void addRow() => setState(() => rows.add(RowData()));

  void removeRow(int index) {
    final row = rows.removeAt(index);
    row.dispose();
    setState(() {});
  }

  String formatNumber(num n) {
    final formatted = NumberFormat('#,##0', 'en_US').format(n);
    if (widget.languageCode == 'bn') return toBengaliNumber(formatted);
    return formatted;
  }

  @override
  void dispose() {
    for (final r in rows) r.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.green;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(), // dismiss focus when tapping outside
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
            child: AppBar(
              backgroundColor: primaryColor,
              elevation: 4,
              titleSpacing: 1,
              title: Row(
                children: [
                  const SizedBox(width: 12),
                  // Language selector
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: SizedBox(
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          final newLang = widget.languageCode == 'bn' ? 'en' : 'bn';
                          widget.onLanguageChange(newLang);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.language, color: primaryColor, size: 16),
                              const SizedBox(width: 3),
                              Flexible(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                                  child: Text(
                                    widget.languageCode == 'bn' ? 'বাংলা' : 'English',
                                    key: ValueKey(widget.languageCode),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              Icon(Icons.arrow_drop_down, color: primaryColor, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Logo
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/logo.png',
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // About button (fade transition included)
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: SizedBox(
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                AboutPage(languageCode: widget.languageCode),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 400),
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info_outline, color: primaryColor, size: 16),
                              const SizedBox(width: 2),
                              Flexible(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                                  child: Text(
                                    widget.languageCode == 'bn' ? 'সম্পর্কে' : 'Usage',
                                    key: ValueKey(widget.languageCode),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: rows.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) => MoneyRow(
                    rowData: rows[index],
                    formatNumber: formatNumber,
                    onChanged: () => setState(() {}),
                    onRemove: () => removeRow(index),
                    languageCode: widget.languageCode,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: addRow,
                  icon: const Icon(Icons.add),
                  label: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                    child: Text(
                      widget.languageCode == 'bn' ? 'যোগ করুন' : 'Add New',
                      key: ValueKey(widget.languageCode),
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.white,
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                      child: Text(
                        '${widget.languageCode == 'bn' ? 'মোট: ' : 'Total: '}${formatNumber(totalSum)} ${widget.languageCode == 'bn' ? 'টাকা' : 'Tk'}',
                        key: ValueKey('${widget.languageCode}-$totalSum'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowData {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  double get total {
    final amount = double.tryParse(amountController.text.trim()) ?? 0;
    final qty = double.tryParse(qtyController.text.trim()) ?? 0;
    return amount * qty;
  }

  void dispose() {
    amountController.dispose();
    qtyController.dispose();
  }
}

class MoneyRow extends StatelessWidget {
  final RowData rowData;
  final VoidCallback onChanged;
  final VoidCallback onRemove;
  final String Function(num) formatNumber;
  final String languageCode;

  const MoneyRow({
    super.key,
    required this.rowData,
    required this.onChanged,
    required this.onRemove,
    required this.formatNumber,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: Colors.white,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: rowData.amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: languageCode == 'bn' ? 'টাকা' : 'BDT',
                      hintText: languageCode == 'bn' ? '১০০' : '100',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                    ),
                    onChanged: (_) => onChanged(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: rowData.qtyController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: languageCode == 'bn' ? 'সংখ্যা' : 'Qty',
                      hintText: languageCode == 'bn' ? '৫' : '5',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                    ),
                    onChanged: (_) => onChanged(),
                  ),
                ),
                const SizedBox(width: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 110, maxWidth: 120),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                    child: Text(
                      '${formatNumber(rowData.total)} ${languageCode == 'bn' ? 'টাকা' : 'Tk'}',
                      key: ValueKey('${languageCode}-${rowData.total}'),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey.shade900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -3,
          child: Transform.translate(
            offset: const Offset(-4, 0),
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 1.5,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onRemove,
                child: Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Icon(Icons.close, size: 16, color: Colors.grey.shade700),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}