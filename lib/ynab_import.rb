require "ynab_import/version"
require "ynab_import/converter"

require "ynab_import/csv/rewriter"
require "ynab_import/csv/nordea"
require "ynab_import/csv/epos"
require "ynab_import/csv/uc"
require "ynab_import/csv/vpass"

module YnabImport
  # Converter.new("/Users/jens/Downloads/poster.csv", Csv::Nordea, "nordea.csv").convert!
  # Converter.new("/Users/jens/Downloads/UC_1609.csv", Csv::Uc, "uc.csv").convert!
  # Converter.new("/Users/jens/Downloads/20160827_UseHistoryReference.csv", Csv::Epos, "epos.csv").convert!
  Converter.new("/Users/jens/Downloads/201609.csv", Csv::Vpass, "ana.csv").convert!
end
