require "test_helper"
require "ynab_import/csv_preview"

module YnabImport
  class ConverterTest < Minitest::Test
    def test_shinsei
      preview "590601000197645.csv"
    end

    def test_uc
      preview "UC_1712.csv"
    end

    def test_vpass
      preview "201803.csv"
    end

    def test_nordea
      preview "poster.csv"
    end

    private

      def preview(file)
        fixture_file = File.expand_path("test/fixtures/#{file}")
        result = Converter.new(fixture_file).convert
        CsvPreview.new(result).show
      end
  end
end
