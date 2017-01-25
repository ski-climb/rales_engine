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

  describe ".to_date" do

    context 'given a date' do
      it 'returns transactions on the date' do
        date_1 = '2012-03-16 11:55:05'
        date_2 = '2012-03-07 10:54:55'

        transactions_on_date_1 = create_list(:transaction, 3, created_at: date_1)
        transactions_on_date_2 = create_list(:transaction, 3, created_at: date_2)

        expect(Transaction.on_date(date_1)).to eq transactions_on_date_1
        expect(Transaction.on_date(date_2)).to eq transactions_on_date_2
      end
    end

    context 'given no date' do
      it 'returns all transactions' do
        date = nil
        transactions = create_list(:transaction, 5)

        expect(Transaction.on_date(nil)).to eq transactions
      end
    end
  end

  describe ".successful" do
    it 'returns successful transactions' do
      successful_transactions = create_list(:transaction, 3, result: 'success')
      failed_transactions = create_list(:transaction, 3, result: 'failed')

      expect(Transaction.successful).to eq successful_transactions
    end
  end
end
