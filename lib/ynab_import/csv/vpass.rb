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

        def memo
          input[10].to_s + input[11].to_s
        end

        def transaction
          -input[6].to_i
        end
    end
  end
end
