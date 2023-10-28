require "fileutils"

# Formats
require "ynab_import/csv/rewriter"
require "ynab_import/csv/nordea"
require "ynab_import/csv/epos"
require "ynab_import/csv/rakuten"
require "ynab_import/csv/rakuten_debit"
require "ynab_import/csv/shinsei"

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
        csv_rows.each do |row|
          data << rewriter.new(row).to_ynab
        end
        data.compact
      end

      def csv_rows
        @_csv ||= CSV.parse(read_file, col_sep: rewriter::COL_SEP, liberal_parsing: true)
      end

      def read_file
        File.read(input_path).
          force_encoding(rewriter::ENCODING).
          encode("UTF-8", invalid: :replace, undef: :replace, replace: "?")
      end

      def rewriter
        if %w(konto pension Opsparing).any? { |name| input_path.include?(name) }
          Csv::Nordea
        elsif input_path.include? "UseHistoryReference"
          Csv::Epos
        elsif input_path.include?("JPY_CH")
          Csv::Shinsei
        elsif input_path.include?("RB-torihikimeisai")
          Csv::Rakuten
        elsif input_path.include?("RB-debitmeisai")
          Csv::RakutenDebit
        else
          raise "No rewriter found for #{input_path}"
        end
      end
  end
end
