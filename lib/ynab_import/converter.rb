require "fileutils"

# Formats
require "ynab_import/csv/rewriter"
require "ynab_import/csv/nordea"
require "ynab_import/csv/nordea_new"
require "ynab_import/csv/epos"
require "ynab_import/csv/rakuten"
require "ynab_import/csv/shinsei"
require "ynab_import/csv/shinsei_new"
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
        csv_rows.each do |row|
          data << rewriter.new(row).to_ynab
        end
        data.compact
      end

      def csv_rows
        @_csv ||= CSV.parse(read_file, col_sep: rewriter::COL_SEP)
      end

      def read_file
        File.read(input_path).
          force_encoding(rewriter::ENCODING).
          encode("UTF-8", invalid: :replace, undef: :replace, replace: "?")
      end

      def rewriter
        if input_path.include? "poster"
          Csv::Nordea
        elsif input_path.include? "konto"
          Csv::NordeaNew
        elsif input_path.include? "UC"
          Csv::Uc
        elsif input_path.include? "UseHistoryReference"
          Csv::Epos
        elsif input_path =~ /\d{15}.csv/
          Csv::Shinsei
        elsif input_path.include?("JPY_CH")
          Csv::ShinseiNew
        elsif input_path.include?("RB-torihikimeisai")
          Csv::Rakuten
        else
          Csv::Vpass
        end
      end
  end
end
