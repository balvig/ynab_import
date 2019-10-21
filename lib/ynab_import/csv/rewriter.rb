require "csv"

module YnabImport
  module Csv
    class Rewriter
      ENCODING = "ISO-8859-1"
      COL_SEP = ","

      def initialize(row)
        @row = row
      end

      def to_ynab
        return unless valid_data?
        raise "Could not find transaction in #{row}" if transaction_missing?
        [date, payee, category, memo, outflow, inflow]
      end

      private

        attr_reader :row

        def valid_data?
          Date.parse(date.to_s)
        rescue ArgumentError
          false
        end

        def transaction_missing?
          transaction == 0
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
