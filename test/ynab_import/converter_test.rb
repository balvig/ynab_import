require "test_helper"
require "support/csv_preview"

module YnabImport
  class ConverterTest < Minitest::Test
    def test_shinsei
      preview "590601000197645.csv"
    end

    def test_shinsei_new
      preview "JPY_CH_20191102172758.csv"
    end

    def test_epos
      preview "20191107_UseHistoryReference.csv"
    end

    def test_uc
      preview "UC_1712.csv"
    end

    def test_vpass
      preview "201908.csv"
    end

    def test_nordea
      preview "poster.csv"
    end

    def test_nordea_new
      preview "Visa-dankort-konto 8965937189 - 2021.10.06 20.43.csv"
    end

    def test_nordea_new_variation
      preview "Grundkonto 0727399453 - 2021.10.29 15.05.csv"
    end

    def test_rakuten
      preview "RB-torihikimeisai (1).csv"
    end

    private

      def preview(file)
        fixture_file = File.expand_path("test/fixtures/#{file}")
        result = Converter.new(fixture_file).convert
        CsvPreview.new(result).show
      end
  end
end
