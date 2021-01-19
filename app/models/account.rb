class Account < ApplicationRecord
    validates_presence_of :name, :account_number, :balance, :token
    validates_uniqueness_of :account_number, :token

    def self.transfer(account, destination_account, amount)
        puts "Transfering #{amount} from account #{account.id} to account #{destination_account.id}"
        return false unless self.amount_valid?(amount, account)
        account.balance -= amount
        destination_account.balance += amount
        account.save!

    end
    private
    def self.amount_valid?(amount, account)
        if amount <= 0 or account.balance < amount
            puts 'Transaction failed! Not enough founds or negative integers'
            return false
        end
    return true
    end
end
