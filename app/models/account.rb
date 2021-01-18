class Account < ApplicationRecord
    validates_presence_of :name, :account_number, :balance, :token
    validates_uniqueness_of :account_number, :token

    def self.transfer(account, destination_account, amount)
        puts "Transfering #{amount} from account #{account.id} to account #{destination_account.id}"
        account.balance -= amount
        destination_account.balance += amount
        destination_account.save
        account.save
    end
end
