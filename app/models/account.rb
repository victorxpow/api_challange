class Account < ApplicationRecord
    validates_presence_of :name, :account_number, :balance, :token
    validates_uniqueness_of :account_number, :token
end
