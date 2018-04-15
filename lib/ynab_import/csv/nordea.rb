require "money"
require "money/bank/google_currency"
Money::Bank::GoogleCurrency.ttl_in_seconds = 86400
Money.default_bank = Money::Bank::GoogleCurrency.new

module YnabImport
  module Csv
    class Nordea < Rewriter
      COL_SEP = ";"

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
          transaction_in_dkk.exchange_to(:JPY)
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
