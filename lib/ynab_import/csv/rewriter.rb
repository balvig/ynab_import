require "csv"
require "ynab_import/ynab_row"
require "ynab_import/currency"

module YnabImport
  module Csv
    class Rewriter
      ENCODING = "ISO-8859-1"
      COL_SEP = ","

      def initialize(row, target_currency: :DKK)
        @row = row
        @target_currency = target_currency
      end

      def to_ynab
        return unless valid_data?

        YnabRow.new(
          date: date,
          payee: payee,
          memo: memo,
          outflow: exchange(outflow),
          inflow: exchange(inflow)
        ).to_csv
      end

      private

        attr_reader :row, :target_currency

        def valid_data?
          Date.parse(date.to_s)
        rescue ArgumentError
          false
        end

        def memo
          nil
        end

        def transaction
          raise "define tranction _or_ outflow/inflow in child class"
        end

        def outflow
          transaction < 0 ? transaction.abs : nil
        end

        def inflow
          transaction > 0 ? transaction : nil
        end

        def currency
          raise "define currency in child class"
        end

        def exchange(amount)
          return amount if currency == target_currency

          Money.from_amount(amount.to_f, currency).exchange_to(target_currency)
        rescue => e
          puts "Warning: Failed to convert currency: #{e.message}"
        end
    end
  end
end
