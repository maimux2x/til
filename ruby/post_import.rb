class PostImporter
  class ImportError < StandardError
    def initialize(message = 'Failed to import', row_number:, raw_row:, reason:)
      @row_number = row_number
      @raw_row    = raw_row
      @reason     = reason

      super(message)
    end

    attr_reader :row_number, :raw_row, :reason
  end

  def import(rows)
    rows.each.with_index(1) do |row, i|
      if date?(row[0])
        puts row[0]
      else
        log(i, row[0], "invalid_date")
      end

      if valid_title?(row[1])
        puts row[1]
      else
        log(i, row[1], "missing_title")
      end

      puts row[2]
    end
  end

  private

  def date?(date)
    date.match?(/\d{4}-\d{2}-\d{2}/)
  end

  def valid_title?(title)
    !title.empty?
  end

  def log(row_number, raw_row, reason)
    raise ImportError.new(row_number:, raw_row:, reason:) 
  end
end

rows = [
  ["2026-01-01", "title1", "body1"],
  ["bad-date",  "title2", "body2"],
  ["2026-01-03", "",      "body3"],
]

importer = PostImporter.new

begin
  importer.import(rows)
rescue PostImporter::ImportError => e
  puts "#{e.row_number}:#{e.raw_row}(#{e.message} #{e.reason})"
end
