module YnabImport
  module Csv
    class Rakuten < Rewriter
      ENCODING = "Shift_JIS"

      private

        def date
          Date.parse(row[0]).to_s
        end

        def payee
          row[3]
        end

        def transaction
          row[1].to_i
        end

        def currency
          :JPY
        end
    end
  end
end
