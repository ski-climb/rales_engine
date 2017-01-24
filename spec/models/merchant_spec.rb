require 'rails_helper'

describe Merchant do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:updated_at) }
    it { is_expected.to validate_presence_of(:created_at) }
  end

  describe 'relationships' do
    it { is_expected.to respond_to(:items) }
  end
end
