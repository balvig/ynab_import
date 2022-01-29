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
          row[3].to_s.delete('.').gsub(',','.').to_f
        end

        def currency
          :DKK
        end
    end
  end
end
