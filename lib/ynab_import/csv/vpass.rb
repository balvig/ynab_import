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
          if regular_version?
            input[10].to_s + input[11].to_s
          else
            input[6]
          end
        end

        def transaction
          if regular_version?
            -input[6].to_i
          else
            -input[5].to_i
          end
        end

        def regular_version?
          input[5].to_s.start_with?("'")
        end
    end
  end
end
