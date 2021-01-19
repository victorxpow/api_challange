module Api
  module V1
    class AccountsController < ApplicationController
      def create
        account = Account.create(account_params)
        render json: account, status: :created
      end

      def transfer
        account = Account.find_by!(params[:account_number])

        destination_account_param = params.permit(:destination_account_number)
        destination_account = Account.find_by!(destination_account_param[:destination_account_number])
        return head :not_found unless destination_account

        return head :unprocessable_entity unless Account.transfer(account, destination_account, amount)

        render json: { transfered: true, message: 'Successfully transaction!' }
      end

      def balance
        account = Account.find_by!(params[:account_number])

        render json: account.balance, status: :ok
      end

      private

      def account_params
        params.require(:account).permit(:name, :balance, :account_number, :token)
      end

      def amount
        param = params.permit(:amount)
        param[:amount].to_i
      end
    end
  end
end
