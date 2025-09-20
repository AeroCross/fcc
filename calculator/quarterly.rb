# frozen_string_literal: true

require_relative "base"

module Calculator
  class Quarterly < Base
    private

    def calculate
      (principal * (1 + quarterly_interest_rate)**quarters_in_term).round
    end

    def quarterly_interest_rate
      (rate / 100.0) / 4.0
    end

    def quarters_in_term
      (term / 12.0) * 4.0
    end
  end
end
