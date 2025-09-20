# frozen_string_literal: true

require_relative "base"

module Calculator
  class Maturity < Base
    private

    def calculate
      (principal + (principal * daily_interest_rate * term_in_days)).round
    end

    def daily_interest_rate
      (rate / 100.0) / 365.0
    end

    def term_in_days
      (term * (365.0 / 12.0))
    end
  end
end
