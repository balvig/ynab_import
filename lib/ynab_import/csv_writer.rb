require "ynab_import/utils"

module YnabImport
  class CsvWriter
    def initialize(rows, output_path: "output.csv")
      @rows = rows
      @output_path = output_path
    end

    def write
      File.write(output_path, Utils.array_to_csv(rows))
    end

    private

      attr_reader :rows, :output_path
  end
end
