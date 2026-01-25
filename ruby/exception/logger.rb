require 'fileutils'

def logger(log, &block)
  FileUtils.mkdir_p('ruby')

  input = ''

  begin
    block.call
  rescue => e
    input << "[ERROR] #{e.class}: #{e.message}\n"
  ensure
    input << log
  end

  File.open('ruby/log.txt', 'a') {|f|
    f << input
  }
end

log = <<~TEXT
  2026-01-25 12:00:00 reading a book about logic
  2026-01-25-13:00:00 study about Ruby::Box
  2026-01-25-15:00:00 try CSVImport task
  2026-01-25 19:28:00 study about exception
TEXT

logger(log) do
  1 / 0
end
