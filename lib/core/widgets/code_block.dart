import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeBlock extends StatelessWidget {
  const CodeBlock({required this.code, super.key});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Exemple de code Java',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              tooltip: 'Copier le code',
              onPressed: () => Clipboard.setData(ClipboardData(text: code)),
              icon: const Icon(Icons.copy_rounded, color: Colors.white70),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SelectableText(
                code,
                style: const TextStyle(
                  color: Color(0xFFF9FAFB),
                  fontFamily: 'monospace',
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
