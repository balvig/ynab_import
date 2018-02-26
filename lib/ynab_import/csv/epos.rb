module YnabImport
  module Csv
    class Epos < Rewriter
      ENCODING = "Shift_JIS"

      private

        def date
          row[1].to_s.sub("年", "/").sub("月", "/").sub("日", "")
        end

        def payee
          row[2]
        end

        def memo
          row[7]
        end

        def transaction
          -row[4].to_i
        end
    end
  end
end
