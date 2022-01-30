module YnabImport
  module Csv
    class Nordea < Rewriter
      ENCODING = "UTF-8"
      COL_SEP = ";"

      private

        def date
          row[0]
        end

        def payee
          row[5].to_s.gsub('Dankort-nota ','').gsub(/[\s\d]+$/,'').squeeze(' ')
        end

        def memo
          nil
        end

        def transaction
          row[1].sub(",", ".").to_f
        end

        def currency
          :DKK
        end
    end
  end
end
