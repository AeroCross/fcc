# frozen_string_literal: true

require_relative "money_formatter"
require "optparse"

options = {}
parser = OptionParser.new
parser.on("-a INT", "--amount", "Amount to deposit (e.g 15600)")
parser.on("-t INT", "--term", "How long the term deposit is in months (e.g 36)")
parser.on("-r FLOAT", "--rate", "Interest rate per annum (e.g 1.2)")
parser.on("-c STR", "--cadence", %w[annually quarterly monthly maturity], "How often is interest paid")
parser.parse!(into: options)

required_options = [:amount, :term, :rate, :cadence]
missing_options = required_options - options.keys

unless missing_options.empty?
  fail "Missing required options: #{missing_options}"
end

balance = case options[:cadence]
when "maturity"
  require_relative "calculator/maturity"
  Calculator::Maturity.new(principal: options[:amount], rate: options[:rate], term: options[:term]).call
when "annually"
  require_relative "calculator/annual"
  Calculator::Annual.new(principal: options[:amount], rate: options[:rate], term: options[:term]).call
when "quarterly"
  require_relative "calculator/quarterly"
  Calculator::Quarterly.new(principal: options[:amount], rate: options[:rate], term: options[:term]).call
when "monthly"
  require_relative "calculator/monthly"
  Calculator::Monthly.new(principal: options[:amount], rate: options[:rate], term: options[:term]).call
else
  raise NotImplementedError
end

puts "Final balance: #{MoneyFormatter.new(balance)}"
