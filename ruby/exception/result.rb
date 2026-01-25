class PostImporter
  def import(row, i)
    return log(i, row[0], :invalid_date) unless date?(row[0])
    return log(i, row[1], :missing_title) unless valid_title?(row[1])

    [true, {date: row[0], title: row[1], body: row[2]}]
  end

  private

  def date?(date)
    date.match?(/\A\d{4}-\d{2}-\d{2}\z/)
  end

  def valid_title?(title)
    !title.empty?
  end

  def log(row_number, raw_row, reason)
    [false, {row_number:, raw_row:, reason:}]
  end
end

rows = [
  ['2026-01-01', 'title1', 'body1'],
  ['bad-date',  'title2', 'body2'],
  ['2026-01-03', '',      'body3'],
]

importer = PostImporter.new

result = rows.map.with_index(1) do |row, i|
  importer.import(row, i)
end

successes, errors = result.partition { it[0] }

p success_values = successes.map { it[1] }

p error_values = errors.map { it[1] }
