import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GreatStateDriftMystery(),
    );
  }
}

class GreatStateDriftMystery extends StatefulWidget {
  const GreatStateDriftMystery({super.key});

  @override
  State<GreatStateDriftMystery> createState() => _GreatStateDriftMysteryState();
}

class _GreatStateDriftMysteryState extends State<GreatStateDriftMystery> {
  final List<String> _myTasks = ['Task A', 'Task B', 'Task C', 'Task D', 'Task E'];

  void _deleteFirstItem() {
    setState(() {
      if (_myTasks.isNotEmpty) {
        _myTasks.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Horizontal Tasks'),
        centerTitle: true,
      ),
      body: _myTasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks left!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            )
          : SizedBox(
              height: 180, // Bounds the height of the horizontal row
              child: ListView.separated(
                scrollDirection: Axis.horizontal, // ← Changes scroll to horizontal
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _myTasks.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final task = _myTasks[index];
                  return TaskTile(
                    key: ValueKey(task), // Preserves state
                    title: task,
                  );
                },
              ),
            ),
      floatingActionButton: _myTasks.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _deleteFirstItem,
              label: const Text('Delete First'),
              icon: const Icon(Icons.delete_sweep),
            )
          : null,
    );
  }
}

class TaskTile extends StatefulWidget {
  final String title;

  const TaskTile({super.key, required this.title});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 200, // ← Explicit width ensures cards look consistent in a row
      child: Card(
        elevation: 0,
        color: isChecked ? theme.colorScheme.primaryContainer.withOpacity(0.3) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isChecked ? theme.colorScheme.primary : Colors.grey.shade300,
            width: isChecked ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: isChecked ? theme.colorScheme.primary : Colors.grey,
                  ),
                  Transform.scale(
                    scale: 0.9,
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                  color: isChecked ? Colors.grey : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}