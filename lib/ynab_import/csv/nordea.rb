require "money"
require "money/bank/open_exchange_rates_bank"
oxr = Money::Bank::OpenExchangeRatesBank.new
oxr.app_id = "66c582cad642474fb1db6c1c0b071fcd"
oxr.update_rates
Money.default_bank = oxr

module YnabImport
  module Csv
    class Nordea < Rewriter
      COL_SEP = ";"
      CONVERT_TO_JPY = false

      private

        def date
          row[0]
        end

        def payee
          row[1].to_s.gsub('Dankort-nota ','').gsub(/[\s\d]+$/,'').squeeze(' ')
        end

        def memo
          row[3].to_s + " DKK"
        end

        def transaction
          result = transaction_in_dkk
          result = result.exchange_to(:JPY) if CONVERT_TO_JPY
          result
        end

        def transaction_in_dkk
          Money.new(raw_transaction * 100, :DKK)
        end

        def raw_transaction
          row[3].to_s.delete('.').gsub(',','.').to_f
        end
    end
  end
end
