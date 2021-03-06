require 'rails_helper'

RSpec.describe Account, type: :model do
  let!(:account) { create(:account, balance: 100) }
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:account_number) }
    it { should validate_presence_of(:balance) }
    it { should validate_presence_of(:token) }
    it { should validate_uniqueness_of(:account_number) }
  end

  describe '#transfer' do
    let(:destination_account_params) { attributes_for(:account) }
    let!(:destination_account) { create(:account, destination_account_params) }

    context 'with valid params' do
      it 'transfer from one account to another account' do
        transfered = Account.transfer(account, destination_account, 10)
        expect(transfered).to eq true
        expect(account.balance).to eq 90
      end
    end

    context 'validations' do
      it 'amount must be positive greater than one integer' do
        transfered = Account.transfer(account, destination_account, -10)
        expect(transfered).to eq false
      end

      it 'the balance must be greater than the amount of transaction' do
        transfered = Account.transfer(account, destination_account, 110)
        expect(transfered).to eq false
      end
    end
  end
end
