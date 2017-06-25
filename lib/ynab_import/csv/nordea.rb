require "exchange"

module YnabImport
  module Csv
    class Nordea < Rewriter
      private

        def col_sep
          ";"
        end

        def date
          input[0]
        end

        def payee
          input[1].to_s.gsub('Dankort-nota ','').gsub(/[\s\d]+$/,'').squeeze(' ')
        end

        def memo
          input[3].to_s + " DKK"
        end

        def transaction
          raw_transaction.in(:dkk).to(:jpy).to_f
        end

        def raw_transaction
          input[3].to_s.delete('.').gsub(',','.').to_f
        end
    end
  end
end
