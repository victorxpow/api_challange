require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let!(:accounts) { create_list(:account, 10) }
  let(:account_id) { accounts.first.id }

  describe 'GET /accounts' do
    before { get '/accounts' }

    it 'returns accounts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
