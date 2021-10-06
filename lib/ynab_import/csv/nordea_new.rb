module YnabImport
  module Csv
    class NordeaNew < Rewriter
      COL_SEP = ";"

      private

        def date
          row[0]
        end

        def payee
          row[5]
        end

        def memo
          nil
        end

        def transaction
          row[1].to_i
        end
    end
  end
end
