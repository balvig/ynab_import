require "Csv"

module YnabImport
  module Csv
    class Rewriter
      ENCODING = "ISO-8859-1:UTF-8"

      def initialize(row)
        @row = row
      end

      def to_ynab
        [date, payee, category, memo, outflow, inflow]
      end

      private

        attr_reader :row

        def input
          @_input ||= CSV.parse(row, col_sep: col_sep).first
        end

        def col_sep
          ","
        end

        def category
          nil
        end

        def memo
          nil
        end

        def outflow
          transaction < 0 ? transaction.abs : nil
        end

        def inflow
          transaction > 0 ? transaction : nil
        end
    end
  end
end
