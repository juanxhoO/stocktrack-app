import 'package:flutter/material.dart';

class AppTableColumn {
  final String label;

  const AppTableColumn({required this.label});
}

class AppTableRow {
  final List<Widget> cells;

  const AppTableRow({required this.cells});
}

class AppTable extends StatelessWidget {
  final List<AppTableColumn> columns;
  final List<AppTableRow> rows;

  const AppTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: constraints.maxWidth,
              child: DataTable(
                columns: columns
                    .map((column) => DataColumn(label: Text(column.label)))
                    .toList(),
                rows: rows
                    .map(
                      (row) => DataRow(
                        cells: row.cells.map((cell) => DataCell(cell)).toList(),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
