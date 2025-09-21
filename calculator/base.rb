# frozen_string_literal: true

require_relative "error"

module Calculator
  class Base
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

    attr_reader :principal, :rate, :term

    def ensure_valid_principal
      raise Error::InvalidPrincipal if principal < self.class::MINIMUM_PRINCIPAL_AMOUNT
    end

    def ensure_valid_term
      raise Error::InvalidTerm if term < self.class::MINIMUM_TERM_LENGTH
    end

    def calculate
      raise NotImplementedError
    end
  end
end
