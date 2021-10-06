module YnabImport
  module Csv
    class NordeaNew < Rewriter
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
    end
  end
end
