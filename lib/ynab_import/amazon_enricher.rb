require "ynab"
require "csv"

module YnabImport
  class AmazonEnricher
    def initialize(input_path:, ynab_access_token:)
      @input_path = input_path
      @access_token = ynab_access_token
      @budget_id = "10e3accd-94e7-4c37-b82e-f97448125ccc"
      @account_id = "c0feefdd-5d34-4017-a50b-c6ea64d3520e"
    end

    def enrich
      ynab_api.transactions.get_transactions_by_account(budget_id, account_id, type: "uncategorized").data.transactions.each do |t|
        if t.payee_name.include?("amazon.co.jp")
          csv_rows.each do |row|
            csv_amount = row.field("商品小計")
            next if csv_amount.empty?

            csv_amount = csv_amount.to_i
            ynab_amount = -t.amount / 1000

            if csv_amount == ynab_amount
              name = row.field("商品名")
              amazon_date = Date.parse(row[0])#.field("注文日")
              puts "Potential match found"
              puts "Paid on: #{t.date}
              puts "Ordered: #{amazon_date}"
              puts "Amount: #{ynab_amount}"
              puts "Name: #{name}"
              puts "Write to memo? (y/n)"
              if gets.chomp == "y"
                puts "Writing to memo..."
                puts ynab_api.transactions.update_transaction(budget_id, t.id, transaction: { memo: name })
              end
            end
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
        @_csv_rows ||= CSV.parse(read_file, liberal_parsing: true, headers: true)
      end

      def read_file
        File.read(input_path).encode("UTF-8", invalid: :replace, undef: :replace, replace: "?")
      end
  end
end
