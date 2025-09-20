# frozen_string_literal: true

require_relative "../../calculator/annual"
require_relative "../../calculator/error"

module Calculator
  RSpec.describe Annual do
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
        let(:term) { 36 }

        it "returns the reference result" do
          expect(result).to eq(10_334)
        end
      end

      context "when all the values are different from the reference" do
        let(:principal) { 72_300 }
        let(:rate) { 3.60 }
        let(:term) { 18 } # 1 year, 6 months

        it "returns the correct final balance" do
          expect(result).to eq(76_239)
        end
      end
    end

    describe "term scenarios" do
      context "when the term is not a full year" do
        let(:principal) { 10_000 }
        let(:rate) { 1.10 }
        let(:term) { 20 } # 1 year, 8 months

        it "returns the correct final balance" do
          expect(result).to eq(10_184)
        end
      end

      context "when the term length is the same as the minimum" do
        let(:principal) { 1000 }
        let(:rate) { 1.10 }
        let(:term) { 12 }

        it "returns the correct final balance" do
          expect(result).to eq(1011)
        end
      end
    end

    describe "principal deposit scenarios" do
      context "when the principal is the same as the minimum" do
        let(:principal) { 1000 }
        let(:rate) { 1.10 }
        let(:term) { 12 }

        it "returns the correct final balance" do
          expect(result).to eq(1011)
        end
      end
    end

    describe "interest rate scenarios" do
      context "when the interest rate is different from the reference" do
        let(:principal) { 10_000 }
        let(:rate) { 3.43 }
        let(:term) { 36 }

        it "returns the correct final balance" do
          expect(result).to eq(11_065)
        end
      end

      context "when the interest rate is an integer" do
        let(:principal) { 10_000 }
        let(:rate) { 2 }
        let(:term) { 36 }

        it "returns the correct final balance" do
          expect(result).to eq(10_612)
        end
      end
    end

    describe "invalid scenarios" do
      context "when the principal is lower than the minimum" do
        let(:principal) { 900 }
        let(:rate) { 1.10 }
        let(:term) { 12 }

        it "raises an error" do
          expect { result }.to raise_error(Error::InvalidPrincipal)
        end
      end

      context "when the term length is lower than the minimum" do
        let(:principal) { 12_000 }
        let(:rate) { 2.30 }
        let(:term) { 10 }

        it "raises an error" do
          expect { result }.to raise_error(Error::InvalidTerm)
        end
      end
    end
  end
end
