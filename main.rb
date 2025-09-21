# frozen_string_literal: true

require_relative "money_formatter"
require_relative "calculator/error"
require "optparse"

options = {}
# Usage: main --amount 10000 --term 36 --rate 1.1 --cadence maturity
parser = OptionParser.new
parser.on("-a INT", "--amount", OptionParser::DecimalNumeric, "Amount to deposit (e.g 15600)")
parser.on("-t INT", "--term", OptionParser::DecimalNumeric, "How long the term deposit is in months (e.g 36)")
parser.on("-r FLOAT", "--rate", OptionParser::DecimalNumeric, "Interest rate per annum (e.g 1.2)")
parser.on("-c STR", "--cadence", %w[annually quarterly monthly maturity], "How often is interest paid")

begin
  parser.parse!(into: options)
rescue OptionParser::InvalidArgument => e
  puts e.message
  puts
  puts parser
  exit(-1)
end

required_options = [:amount, :term, :rate, :cadence]
missing_options = required_options - options.keys

unless missing_options.empty?
  puts "Missing required options: #{missing_options}"
  exit(-1)
end

balance = begin
  case options[:cadence]
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
rescue Calculator::Error::InvalidTerm, Calculator::Error::InvalidPrincipal => e
  puts e.message
  exit(-1)
end

puts "Final balance: #{MoneyFormatter.new(balance)}"
