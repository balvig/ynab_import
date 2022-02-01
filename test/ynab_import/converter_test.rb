require "test_helper"
require "support/csv_preview"

module YnabImport
  class ConverterTest < Minitest::Test
    def test_shinsei
      preview "JPY_CH_20220129220422.csv"
    end

    def test_epos
      preview "20191107_UseHistoryReference.csv"
    end

    def test_nordea
      preview "Visa-dankort-konto 8965937189 - 2021.10.06 20.43.csv"
    end

    def test_nordea_variation
      preview "Grundkonto 0727399453 - 2021.10.29 15.05.csv"
    end

    def test_nordea_rate_pension
      preview "Ratepension-pulje 0717886992 - 2022.02.01 20.06.csv"
    end

    def test_rakuten
      preview "RB-torihikimeisai (1).csv"
    end

    private

      def preview(file)
        fixture_file = File.expand_path("test/fixtures/#{file}")
        result = Converter.new(fixture_file).convert
        CsvPreview.new(result).show
      rescue Errno::ENOENT
        skip "#{fixture_file} not found, skipping."
      end
  end
end
