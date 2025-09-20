# frozen_string_literal: true

module Calculator
  class Maturity
    MINIMUM_PRINCIPAL_AMOUNT = 1000 # dollars
    MINIMUM_TERM_LENGTH = 3 # months

    # @param principal [Integer] Principal deposit, in dollars
    # @param rate [Float] Interest rate per annum
    # @param term [Integer] How long the investment term is, in months
    def initialize(principal:, rate:, term:)
      @principal = principal.to_f
      @rate = rate.to_f
      @term = term.to_f
    end

    def call
      ensure_valid_principal
      ensure_valid_term
      calculate
    end

    private

    def ensure_valid_principal
      raise Error::InvalidPrincipal if @principal.to_f < MINIMUM_PRINCIPAL_AMOUNT
    end

    def ensure_valid_term
      raise Error::InvalidTerm if @term.to_f < MINIMUM_TERM_LENGTH
    end

    def calculate
      (@principal + (@principal * daily_interest_rate * term_in_days)).round
    end

    def daily_interest_rate
      (@rate.to_f / 100.0) / 365.0
    end

    def term_in_days
      (@term.to_f * (365.0 / 12.0))
    end
  end
end
