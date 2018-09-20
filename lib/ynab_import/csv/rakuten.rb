module YnabImport
  module Csv
    class Rakuten < Rewriter
      ENCODING = "Shift_JIS"

      private

        def date
          row[0]
        end

        def payee
          row[3]
        end

        def transaction
          row[1].to_i
        end
    end
  end
end
