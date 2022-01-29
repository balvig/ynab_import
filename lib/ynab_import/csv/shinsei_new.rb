module YnabImport
  module Csv
    class ShinseiNew < Rewriter
      ENCODING = "UTF-8"

      private

        def date
          row[0]
        end

        def payee
          row[1]
        end

        def outflow
          row[2]
        end

        def inflow
          row[3]
        end

        def currency
          :JPY
        end
    end
  end
end
