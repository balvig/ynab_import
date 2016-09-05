module YnabImport
  module Csv
    class Vpass < Rewriter
      ENCODING = "Shift_JIS:UTF-8"

      private

        def date
          input[0]
        end

        def payee
          input[1]
        end

        def transaction
          -input[2].to_i
        end
    end
  end
end
