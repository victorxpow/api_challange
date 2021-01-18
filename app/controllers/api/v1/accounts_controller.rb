module Api
    module V1
        class AccountController < ApplicationController
            def transfer
                account = Account.find(params[:id])
            
                recipient_param = params.permit(:recipient_id)
                recipient = Account.find(recipient_param[:recipient_id])
            
                return head :unprocessable_entity unless Account.transfer(account, recipient, amount)
                render json: {transfered: true}
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
end
