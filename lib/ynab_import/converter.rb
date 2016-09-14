require "csv"
require "fileutils"
require "terminal-table"

module YnabImport
  class Converter

    def initialize(input_path, rewriter, output_path = "output.csv")
      @input_path = input_path
      @output_path = output_path
      @rewriter = rewriter
    end

    def convert!
      rewrite_csv
      print_preview
      remove_input_file
    rescue Errno::ENOENT
      puts "Couldn't find file #{@input_path}"
    end

    private

      def rewrite_csv
        file = File.readlines(@input_path, encoding: @rewriter::ENCODING)
        CSV.open(@output_path, "wb") do |output|
          output << %w{ Date Payee Category Memo Outflow Inflow }
          file[2..-1].each do |row|
            output << @rewriter.new(row).to_ynab
          end
        end
      end

      def print_preview
        puts Terminal::Table.new(rows: output_csv)
      end

      def output_csv
        CSV.read(@output_path, headers: true, encoding: "UTF-8").to_a
      end

      def remove_input_file
        FileUtils.rm(@input_path)
      end
  end
end
