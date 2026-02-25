class ReadingStats
  attr_reader :notes

  def initialize
    @pages_by_date = Hash.new(0)
    @notes         = []
  end

  def log(date:, pages:, note: nil)
    @pages_by_date[date] += pages

    @notes << note if note
  end

  def pages_on(date)
    @pages_by_date[date]
  end

  def total_pages
    @pages_by_date.values.sum
  end
end

rs = ReadingStats.new
rs.log(date: '2026-02-10', pages: 30, note: 'Hashのdefault')
rs.log(date: '2026-02-10', pages: 20)
rs.log(date: '2026-02-11', pages: 10, note: 'ensure')

p rs.pages_on('2026-02-10')
p rs.total_pages
p rs.notes
