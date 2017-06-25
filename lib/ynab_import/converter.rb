require "csv"
require "fileutils"
require "terminal-table"

module YnabImport
  class Converter
    COLUMNS = %w(Date Payee Category Memo Outflow Inflow)

    def initialize(input_path)
      @input_path = input_path
    end

    def convert
      rewrite_csv
      print_preview
    end

    private

      attr_reader :input_path

      def rewrite_csv
        CSV.open(output_path, "wb") do |output|
          output << COLUMNS
          input_lines.each do |row|
            output << rewriter.new(row).to_ynab
          end
        end
      rescue Encoding::InvalidByteSequenceError => e
        puts e.message
      end

      def input_lines
        @_input_lines ||= File.readlines(input_path, encoding: rewriter::ENCODING)
      end

      def print_preview
        puts Terminal::Table.new(rows: csv_output)
      end

      def csv_output
        CSV.read(output_path, headers: true, encoding: "UTF-8").to_a
      end

      def output_path
        "#{rewriter.name}.csv"
      end

      def rewriter
        if input_path.include? "poster"
          Csv::Nordea
        elsif input_path.include? "UC"
          Csv::Uc
        elsif input_path.include? "UseHistoryReference"
          Csv::Epos
        else
          Csv::Vpass
        end
      end
  end
end
