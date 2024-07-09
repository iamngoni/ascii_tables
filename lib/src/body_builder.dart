part of ascii_tables;

class BodyBuilder {
  late int padding;
  late Map<String, int> column_sizes;

  BodyBuilder(int padd, Map<String, int> col_sizes) {
    this.padding = padd;
    this.column_sizes = col_sizes;
  }

  String fromMap(Map<String, Map<String, String>> map) {
    try {
      List tableRows = [];
      map.forEach((k, v) {
        StringBuffer row = new StringBuffer('|');
        this.column_sizes.forEach((String columnName, int column_size) {
          if (v.containsKey(columnName)) {
            row.write(str_pad(v[columnName]!, column_size + (this.padding * 2),
                ' ', PAD_BOTH));
          } else {
            row.write(str_pad(str_repeat('-', column_size),
                column_size + (this.padding * 2), ' ', PAD_BOTH));
          }
          row.write('|');
        });
        tableRows.add(row.toString());
      });

      return tableRows.join('\n');
    } catch (e, s) {
      print(e);
      print(s);
      return '';
    }
  }
}
