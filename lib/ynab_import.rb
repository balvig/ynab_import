require "ynab_import/version"
require "ynab_import/converter"
require "ynab_import/csv/rewriter"
require "ynab_import/csv/nordea"
require "ynab_import/csv/epos"

module YnabImport
  Converter.new("/Users/jens/Downloads/poster.csv", Csv::Nordea).convert!
  #Converter.new("/Users/jens/Downloads/20160726_UseHistoryReference.csv", Csv::Epos).convert!
end
