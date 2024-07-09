library ascii_tables;

part 'src/body_builder.dart';
part 'src/exceptions.dart';
part 'src/format_string.dart';
part 'src/header_builder.dart';
part 'src/table_measure.dart';

const PAD_RIGHT = 1;
const PAD_LEFT = 2;
const PAD_BOTH = 3;

class AsciiTables {
  bool _isPrintHeaderEnabled = true;
  String? _tableHeaderString;
  String? _tableBodyString;
  int _padding = 1;
  int? _from_type;
  late Map<String, int> _column_sizes;
  Map<String, Map<String, String>> _content_map = new Map();

  AsciiTables() {
    this._column_sizes = new Map();
  }

  TableMeasure _tm = new TableMeasure();

  AsciiTables.fromMap(Map<String, Map<String, String>> map) {
    this._content_map = map;
    this._column_sizes = this._tm.fromMap(map);
  }

  AsciiTables.fromList(List<Map<String, String>> list) {
    this._content_map = new Map.fromIterable(list);
    this._column_sizes = this._tm.fromMap(this._content_map);
  }

  AsciiTables.fromSet(Set set) {
    List tmpList = [];
    set.forEach((element) {
      if (element is Map) {
        tmpList.add(element);
      } else {
        tmpList.add({'item': element});
      }
    });
    this._content_map = new Map.fromIterable(tmpList);
    this._column_sizes = this._tm.fromMap(this._content_map);
  }

  AsciiTables.fromIterator(Iterator<String> i) {
    throw new UnimplementedError();
  }

  void displayHeader(bool display_header) {
    this._isPrintHeaderEnabled = display_header;
  }

  void setPadding(int padding) {
    this._padding = padding;
  }

  void printTable() {
    print(this._makeTable());
  }

  String returnTable() {
    return this._makeTable();
  }

  String _makeTable() {
    StringBuffer table = new StringBuffer();
    HeaderBuilder _hb = new HeaderBuilder(this._padding, this._column_sizes);
    BodyBuilder _bb = new BodyBuilder(this._padding, this._column_sizes);
    this._tableHeaderString = _hb.fromMap(this._content_map);
    this._tableBodyString = _bb.fromMap(this._content_map);

    int total_length = this._column_sizes.length * 2 * this._padding;
    this._column_sizes.forEach((k, v) {
      total_length += v;
    });
    total_length += (this._column_sizes.length - 1);
    table.write('+');
    table.write(str_repeat('-', total_length));
    table.write('+\n');
    if (this._isPrintHeaderEnabled) {
      table.write(this._tableHeaderString);
      table.write('\n');
    }
    table.write(this._tableBodyString);
    table.write('\n+');
    table.write(str_repeat('-', total_length));
    table.write('+');
    return table.toString();
  }
}
