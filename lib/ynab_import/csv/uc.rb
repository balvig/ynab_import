module YnabImport
  module Csv
    class Uc < Rewriter
      ENCODING = "Shift_JIS:UTF-8"

      private

        def date
          input[1]
        end

        def payee
          input[3]
        end

        def memo
          input[7]
        end

        def transaction
          -input[5].to_i
        end
    end
  end
end
