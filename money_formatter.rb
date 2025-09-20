# frozen_string_literal: true

class MoneyFormatter
  def initialize(amount, currency: "AUD")
    @amount = amount
    @currency = currency
  end

  def to_s
    "$#{amount} #{currency}"
  end

  private

  attr_reader :amount, :currency
end
