# frozen_string_literal: true

require_relative "../../calculator/quarterly"
require_relative "../../calculator/error"

module Calculator
  RSpec.describe Quarterly do
    subject(:result) do
      described_class.new(
        principal: principal,
        rate: rate,
        term: term
      ).call
    end

    describe "reference scenarios" do
      context "when compared to the reference example" do
        let(:principal) { 10_000 }
        let(:rate) { 1.10 }
        let(:term) { 36 } # 3 years

        it "returns the reference result" do
          expect(result).to eq(10_335)
        end
      end

      context "when all the values are different from the reference" do
        let(:principal) { 98_300 }
        let(:rate) { 4.05 }
        let(:term) { 60 } # 5 years

        it "returns the correct final balance" do
          expect(result).to eq(120_242)
        end
      end
    end

    describe "term scenarios" do
      context "when the term is not a full year" do
        let(:principal) { 10_000 }
        let(:rate) { 2.39 }
        let(:term) { 59 } # 4 years, 11 months

        it "returns the correct final balance" do
          expect(result).to eq(11_243)
        end
      end

      context "when the term length is the same as the minimum" do
        let(:principal) { 10_000 }
        let(:rate) { 1.10 }
        let(:term) { Quarterly::MINIMUM_TERM_LENGTH }

        it "returns the correct final balance" do
          expect(result).to eq(10_028)
        end
      end
    end

    describe "principal deposit scenarios" do
      context "when the principal is the same as the minimum" do
        let(:principal) { Quarterly::MINIMUM_PRINCIPAL_AMOUNT }
        let(:rate) { 1.10 }
        let(:term) { 12 } # 1 year

        it "returns the correct final balance" do
          expect(result).to eq(1_011)
        end
      end
    end

    describe "interest rate scenarios" do
      context "when the interest rate is different from the reference" do
        let(:principal) { 10_000 }
        let(:rate) { 3.43 }
        let(:term) { 36 } # 3 years

        it "returns the correct final balance" do
          expect(result).to eq(11_079)
        end
      end

      context "when the interest rate is an integer" do
        let(:principal) { 10_000 }
        let(:rate) { 2 }
        let(:term) { 36 } # 3 years

        it "returns the correct final balance" do
          expect(result).to eq(10_617)
        end
      end
    end

    describe "invalid scenarios" do
      context "when the principal is lower than the minimum" do
        let(:principal) { Quarterly::MINIMUM_PRINCIPAL_AMOUNT - 300 }
        let(:rate) { 1.10 }
        let(:term) { 12 } # 1 year

        it "raises an error" do
          expect { result }.to raise_error(Error::InvalidPrincipal)
        end
      end

      context "when the term length is lower than the minimum" do
        let(:principal) { 12_000 }
        let(:rate) { 2.30 }
        let(:term) { Quarterly::MINIMUM_TERM_LENGTH - 2 }

        it "raises an error" do
          expect { result }.to raise_error(Error::InvalidTerm)
        end
      end
    end
  end
end
