module YnabImport
  class YnabRow
    def initialize(date:, payee:, memo: nil, outflow:, inflow:)
      @date = date
      @payee = payee
      @memo = memo
      @outflow = outflow
      @inflow = inflow
    end

    def to_csv
      return unless valid_data?

      [date, payee, category, memo, outflow, inflow]
    end

    private

      attr_reader :date, :payee, :memo, :outflow, :inflow

      def valid_data?
        Date.parse(date.to_s)
      rescue ArgumentError
        false
      end

      def category
        nil
      end
  end
end
