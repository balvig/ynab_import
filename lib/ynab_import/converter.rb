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
      save_rewritten_csv
      print_preview
    end

    private

      attr_reader :input_path

      def save_rewritten_csv
        File.write(output_path, output_csv)
      rescue Encoding::InvalidByteSequenceError => e
        puts e.message
      end

      def output_csv
        rewritten_data.map(&:to_csv).join
      end

      def rewritten_data
        @_rewritten_data ||= rewrite_data
      end

      def rewrite_data
        data = [COLUMNS]
        input_lines.each do |row|
          data << rewriter.new(row).to_ynab
        end
        data
      end

      def input_lines
        @_input_lines ||= File.readlines(input_path, encoding: rewriter::ENCODING)
      end

      def print_preview
        puts Terminal::Table.new(rows: rewritten_data)
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
