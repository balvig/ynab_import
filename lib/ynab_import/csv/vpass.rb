module YnabImport
  module Csv
    class Vpass < Rewriter
      ENCODING = "Shift_JIS"

      def to_ynab
        rewrite_rows_broken_due_to_values_with_commas
        super
      end

      private

        def rewrite_rows_broken_due_to_values_with_commas
          if transaction == 0 # (LUTON, BEDS )
            row[1] += row.delete_at(2)
          end
        end

        def date
          row[0]
        end

        def payee
          row[1]
        end

        def memo
          if regular_version?
            row[10].to_s + row[11].to_s
          else
            row[6]
          end
        end

        def transaction
          if regular_version?
            -row[6].to_i
          else
            -row[5].to_i
          end
        end

        def regular_version?
          row[5].to_s.start_with?("'")
        end
    end
  end
end
