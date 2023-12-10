part of 'widgets.dart';

class ButtonNewIssue extends StatelessWidget {
  const ButtonNewIssue({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.pushNamed('new Issue');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      child: const Text('Submit an Issue'),
    );
  }
}
