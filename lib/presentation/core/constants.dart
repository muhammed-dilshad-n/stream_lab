import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

// Consraints
const kMobileMaxWidth = 820;
const kTabMaxWidth = 1200;

// Colors
final kDefaultBackgroundColor = Colors.grey[300];
final kPrimaryColor = Colors.grey[900];
final kDrawerTextStyle = TextStyle(
  color: Colors.grey[600],
);

// Padding
const kTilePadding = EdgeInsets.only(left: 8.0, right: 8, top: 8);

// Vertical spacing
const kHeightSm = SizedBox(height: 4);
const kHeight = SizedBox(height: 8);
const kHeightLg = SizedBox(height: 12);
const kHeightXl = SizedBox(height: 16);

// Horizontal spacing
const kWidthSm = SizedBox(width: 4);
const kWidth = SizedBox(width: 8);
const kWidthLg = SizedBox(width: 12);
const kWidthXl = SizedBox(width: 16);

// Button styles
final kDefaultButtonStyle = ButtonStyle(
  elevation: const WidgetStatePropertyAll<double>(0),
  padding: const WidgetStatePropertyAll<EdgeInsets>(
    EdgeInsets.all(16),
  ),
  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  backgroundColor: WidgetStatePropertyAll<Color?>(
    kPrimaryColor,
  ),
  foregroundColor: const WidgetStatePropertyAll<Color>(
    Colors.white,
  ),
);

final kDefalutPlutoColumns = [
  PlutoColumn(
    title: 'Key',
    field: 'key',
    type: PlutoColumnType.text(),
    enableRowChecked: true,
    enableContextMenu: false,
    enableSorting: false,
  ),
  PlutoColumn(
    title: 'Value',
    field: 'value',
    type: PlutoColumnType.text(),
    enableContextMenu: false,
    enableSorting: false,
  ),
  PlutoColumn(
    title: 'Description',
    field: 'description',
    type: PlutoColumnType.text(),
    enableContextMenu: false,
    enableSorting: false,
  ),
];

// Intents
class SaveIntent extends Intent {
  const SaveIntent();
}
