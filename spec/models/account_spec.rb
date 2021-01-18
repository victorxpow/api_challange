require 'rails_helper'

RSpec.describe Account, type: :model do
  let!(:account) { create(:account, balance: 100) }
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:account_number) }
    it { should validate_presence_of(:balance) }
    it { should validate_presence_of(:token) }
    it { should validate_uniqueness_of(:account_number) }
  end

  describe '#transfer' do
    let(:params_recipient) { attributes_for(:account)}
    let!(:recipient) { create(:account, params_recipient) }

    context 'with valid params' do
      it 'transfer from one account to another account' do
        transfered = Account.transfer(account, recipient, 10)
        expect(transfered).to eq true
        expect(account.balance).to eq 90
        expect(recipient.balance).to eq 110
      end
    end
  end

end
