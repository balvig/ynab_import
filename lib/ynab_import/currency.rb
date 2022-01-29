require "money"
require "money/bank/open_exchange_rates_bank"

oxr = Money::Bank::OpenExchangeRatesBank.new
oxr.app_id = "66c582cad642474fb1db6c1c0b071fcd"
oxr.update_rates
Money.default_bank = oxr
