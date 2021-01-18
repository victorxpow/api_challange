class Account < ApplicationRecord
    validates_presence_of :name, :account_number, :balance, :token
    validates_uniqueness_of :account_number, :token

    def self.transfer(account, recipient, amount)
        puts "Transfering #{amount} from account #{account.id} to account #{recipient.id}"
        account.balance -= amount
        recipient.balance += amount
        recipient.save
        account.save
    end
end
