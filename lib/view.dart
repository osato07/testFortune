import 'package:flutter/material.dart';
import 'viewmodel.dart';
import 'model.dart';

class FortuneApp extends StatelessWidget {
  FortuneApp({super.key});
  final FortuneViewModel viewModel = FortuneViewModel();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FortunePage(viewModel: viewModel),
    );
  }
}

class FortunePage extends StatefulWidget {
  final FortuneViewModel viewModel;
  const FortunePage({super.key, required this.viewModel});
  @override
  State<FortunePage> createState() => _FortunePageState();
}

class _FortunePageState extends State<FortunePage> {
  FortuneViewModel get vm => widget.viewModel;

  void _onAnswer({required bool yes}) {
    setState(() {
      vm.answer(yes: yes);
    });
  }

  void _onRestart() {
    setState(() {
      vm.restart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = vm.currentNode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple, // ← 背景色
        centerTitle: true,                  // タイトル中央寄せ
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("🔮", style: TextStyle(fontSize: 28)), // ← 絵文字
            SizedBox(width: 8),
            Text(
              "占いアプリ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,        // ← タイトル文字色
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: node is QuestionNode
              ? _buildQuestion(node)
              : _buildResult(node as ResultNode),
        ),
      ),
    );
  }

  Widget _buildQuestion(QuestionNode q) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'YES / NO で答えてください',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 16),
        Text(
          q.text ?? '',
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 180,
          child: ElevatedButton(
            onPressed: () => _onAnswer(yes: true),
            child: const Text('YES'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 180,
          child: ElevatedButton(
            onPressed: () => _onAnswer(yes: false),
            child: const Text('NO'),
          ),
        ),
      ],
    );
  }

  Widget _buildResult(ResultNode r) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          r.emoji ?? '',
          style: const TextStyle(fontSize: 80),
        ),
        const SizedBox(height: 16),
        Text(
          r.title ?? '',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          r.description ?? '',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _onRestart,
          child: const Text('もう一度占う'),
        ),
      ],
    );
  }
}
