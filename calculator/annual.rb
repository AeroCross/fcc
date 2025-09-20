# frozen_string_literal: true

require_relative "base"

module Calculator
  class Annual < Base
    MINIMUM_TERM_LENGTH = 12 # months

    private

    def calculate
      (principal * (1 + annual_interest_rate)**term_in_years).round
    end

    def annual_interest_rate
      rate / 100.0
    end

    def term_in_years
      term / 12.0
    end
  end
end
