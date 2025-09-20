# frozen_string_literal: true

require_relative "base"

module Calculator
  class Monthly < Base
    private

    def calculate
      (principal * (1 + daily_interest_rate * days_per_month)**term).round
    end

    def daily_interest_rate
      (rate / 100.0) / 365.0
    end

    def days_per_month
      (365.0 / 12.0)
    end
  end
end
