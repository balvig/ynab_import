require "ynab"
require "csv"

module YnabImport
  class Enricher
    def initialize(input_path:, ynab_access_token:)
      @input_path = input_path
      @access_token = ynab_access_token
      @budget_id = "10e3accd-94e7-4c37-b82e-f97448125ccc"
      @account_id = "c0feefdd-5d34-4017-a50b-c6ea64d3520e"
    end

    def enrich
      ynab_api.transactions.get_transactions_by_account(budget_id, account_id, type: "uncategorized").data.transactions.each do |t|
        debit_id = t.payee_name[/[AB]0(\d+)/, 1]
        debit_row = csv_rows.find do |row|
          row.field("Memo") == debit_id
        end

        if debit_row
          payee_from_debit = debit_row.field("Payee")
          unless t.payee_name.include?(payee_from_debit)
            puts ynab_api.transactions.update_transaction(budget_id, t.id, transaction: { payee_id: nil, payee_name: payee_from_debit, memo: t.payee_name })
          end
        end
      end
    end

    private

      attr_reader :input_path, :access_token, :budget_id, :account_id

      def ynab_api
        YNAB::API.new(access_token)
      end

      def csv_rows
        @_csv_rows ||= CSV.read(input_path, headers: true)
      end
  end
end
