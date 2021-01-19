require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do

    describe 'POST /api/v1/accounts' do
        context 'with valid attributes' do
            it 'create a new account' do
                name = Faker::Name.name
                token = Faker::Name.name
                balance = Faker::Number.number(digits: 3)
                account_number = Faker::Number.number(digits: 4)
        
                post :create,
                    params: { account: {
                        name: name,
                        balance: balance,
                        account_number: account_number,
                        token: token
                    }}
        
                expect(response.status).to eq(201)
                expect(JSON.parse(response.body)['name']).to eq(name)
                expect(JSON.parse(response.body)['balance']).to eq(balance)
                expect(JSON.parse(response.body)['account_number'].nil?).to be(false)
            end
        end
    end

end