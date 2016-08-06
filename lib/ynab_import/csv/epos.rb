module YnabImport
  module Csv
    class Epos < Rewriter
      ENCODING = "Shift_JIS:UTF-8"

      private

        def date
          input[1].to_s.sub("年", "/").sub("月", "/").sub("日", "")
        end

        def payee
          input[2]
        end

        def memo
          input[7]
        end

        def transaction
          -input[4].to_i
        end
    end
  end
end
