require "terminal-table"

module YnabImport
  class CsvPreview
    def initialize(rows)
      @rows = rows
    end

    def show
      puts Terminal::Table.new(rows: rows)
    end

    private

      attr_reader :rows
  end
end
