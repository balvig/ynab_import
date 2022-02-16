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
      preview "Visa-dankort-konto.csv"
    end

    def test_nordea_variation
      preview "Grundkonto.csv"
    end

    def test_nordea_rate_pension
      preview "Ratepension-pulje.csv"
    end

    def test_rakuten
      preview "RB-torihikimeisai.csv"
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
