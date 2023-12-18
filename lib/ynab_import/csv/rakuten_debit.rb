module YnabImport
  module Csv
    class RakutenDebit < Rewriter
      ENCODING = "Shift_JIS"

      private

        def date
          Date.parse(row[0]).to_s
        end

        def payee
          row[1]
        end

        def memo
          row[8]
        end

        def transaction
          -row[2].to_i
        end

        def currency
          :JPY
        end
    end
  end
end
