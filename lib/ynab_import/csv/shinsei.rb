module YnabImport
  module Csv
    class Shinsei < Rewriter
      ENCODING = "UTF-16"
      COL_SEP = "\t"

      private

        def date
          row[0]
        end

        def payee
          row[2]
        end

        def memo
          nil
        end

        def outflow
          row[3]
        end

        def inflow
          row[4]
        end
    end
  end
end
