require 'rails_helper'

describe Transaction do
  describe "validations" do
    it { is_expected.to validate_presence_of(:result) }
    it { is_expected.to validate_presence_of(:credit_card_number) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:invoice) }
  end

  describe "result" do
    it "success" do
      transaction = create(:transaction, result: 0)
      expect(transaction.success?).to be true
      expect(transaction.result).to eq "success"
    end
    it "failed" do
      transaction = create(:transaction, result: 1)
      expect(transaction.failed?).to be true
      expect(transaction.result).to eq "failed"
    end
  end
end
