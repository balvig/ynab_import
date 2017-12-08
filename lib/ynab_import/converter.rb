require "fileutils"

# Formats
require "ynab_import/csv/rewriter"
require "ynab_import/csv/nordea"
require "ynab_import/csv/epos"
require "ynab_import/csv/shinsei"
require "ynab_import/csv/uc"
require "ynab_import/csv/vpass"

module YnabImport
  class Converter
    COLUMNS = %w(Date Payee Category Memo Outflow Inflow)

    def initialize(input_path)
      @input_path = input_path
    end

    def convert
      converted_data
    end

    private

      attr_reader :input_path

      def converted_data
        data = [COLUMNS]
        input_lines.each do |row|
          data << rewriter.new(row).to_ynab
        end
        data
      end

      def input_lines
        @_input_lines ||= File.readlines(input_path, encoding: rewriter::ENCODING)
      end

      def rewriter
        if input_path.include? "poster"
          Csv::Nordea
        elsif input_path.include? "UC"
          Csv::Uc
        elsif input_path.include? "UseHistoryReference"
          Csv::Epos
        elsif input_path =~ /\d{15}.csv/
          Csv::Shinsei
        else
          Csv::Vpass
        end
      end
  end
end
