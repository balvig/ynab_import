require "money"
require "money/bank/open_exchange_rates_bank"

oxr = Money::Bank::OpenExchangeRatesBank.new
oxr.app_id = "66c582cad642474fb1db6c1c0b071fcd"
begin
oxr.update_rates
rescue => e
  puts "Warning: Failed to update currency rates: #{e.message}"
end
Money.default_bank = oxr
I18n.enforce_available_locales = false
