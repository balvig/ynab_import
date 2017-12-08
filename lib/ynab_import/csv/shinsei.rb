module YnabImport
  module Csv
    class Shinsei < Rewriter
      ENCODING = "UTF-16:UTF-8"

      private

        def col_sep
          "\t"
        end

        def date
          input[0]
        end

        def payee
          input[2]
        end

        def memo
          nil
        end

        def outflow
          input[3]
        end

        def inflow
          input[4]
        end
    end
  end
end
