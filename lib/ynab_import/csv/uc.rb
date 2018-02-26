module YnabImport
  module Csv
    class Uc < Rewriter
      ENCODING = "Shift_JIS"

      private

        def date
          row[1]
        end

        def payee
          row[3]
        end

        def memo
          row[8]
        end

        def transaction
          -row[7].to_i
        end
    end
  end
end
