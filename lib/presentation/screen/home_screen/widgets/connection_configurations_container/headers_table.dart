import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:stream_lab/application/connection/connection_form/connection_form_bloc.dart';
import 'package:stream_lab/presentation/core/constants.dart';
import 'package:stream_lab/presentation/screen/home_screen/widgets/connection_configurations_container/table_no_row_widget.dart';

class HeadersTable extends StatelessWidget {
  const HeadersTable({super.key});

  @override
  Widget build(BuildContext context) {
    PlutoGridStateManager? stateManager;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: BlocConsumer<ConnectionFormBloc, ConnectionFormState>(
        listener: (context, state) {
          stateManager?.removeAllRows();
          stateManager?.appendRows(state.connectionFormData!.headers);
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  kWidth,
                  const Text(
                    'Headers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (state.connectionFormData!.headers
                          .any((element) => element.checked == true)) {
                        FlushbarHelper.createAction(
                          message:
                              'Are you sure you want to delete selected rows?',
                          button: TextButton(
                            style: const ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll<Color>(
                                Colors.red,
                              ),
                            ),
                            onPressed: () {
                              context.read<ConnectionFormBloc>().add(
                                  const ConnectionFormEvent
                                      .deleteSelectedHeaders());
                              Navigator.pop(context);
                            },
                            child: const Text('DELETE'),
                          ),
                          duration: const Duration(seconds: 5),
                        ).show(context);
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: state.connectionFormData!.headers
                              .any((element) => element.checked == true)
                          ? Colors.red
                          : Colors.grey[600],
                    ),
                  ),
                  kWidth,
                  IconButton(
                    onPressed: () => context
                        .read<ConnectionFormBloc>()
                        .add(const ConnectionFormEvent.addHeader()),
                    icon: const Icon(Icons.add),
                  ),
                  kWidth,
                ],
              ),
              Expanded(
                child: PlutoGrid(
                  columns: kDefalutPlutoColumns,
                  rows: state.connectionFormData!.headers.toList(),
                  configuration: PlutoGridConfiguration(
                    enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveRight,
                    columnSize: const PlutoGridColumnSizeConfig(
                      autoSizeMode: PlutoAutoSizeMode.scale,
                    ),
                    style: PlutoGridStyleConfig(
                      gridBackgroundColor: Colors.transparent,
                      rowColor: Colors.transparent,
                      activatedColor: Colors.transparent,
                      cellColorInEditState: Colors.grey[400]!,
                      activatedBorderColor: kPrimaryColor!,
                    ),
                  ),
                  noRowsWidget: TableNoRowWidget(
                    text: 'There is no headers available at this moment',
                    onPressed: () => context
                        .read<ConnectionFormBloc>()
                        .add(const ConnectionFormEvent.addHeader()),
                  ),
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                  },
                  onRowChecked: (event) async {
                    if (event.isAll && event.isChecked != null) {
                      context
                          .read<ConnectionFormBloc>()
                          .add(ConnectionFormEvent.headerAllRowsChecked(
                            isChecked: event.isChecked!,
                          ));
                    } else if (event.rowIdx != null && event.row != null) {
                      context
                          .read<ConnectionFormBloc>()
                          .add(ConnectionFormEvent.headerRowChecked(
                            rowIndex: event.rowIdx!,
                            row: event.row!,
                          ));
                    }
                  },
                  onChanged: (event) => context
                      .read<ConnectionFormBloc>()
                      .add(ConnectionFormEvent.headerRowChanged(
                        rowIndex: event.rowIdx,
                        row: event.row,
                      )),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
