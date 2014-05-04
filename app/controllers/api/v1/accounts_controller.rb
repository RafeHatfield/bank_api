module Api
  module V1
    class AccountsController < ApplicationController
      before_filter :restrict_access, except: [:authenticate]

      respond_to :json

      def authenticate
        # using httparty on atm for simplicity, however it renames header vars weirdly; putting check here to allow api to still work when not using httparty
        cardnum = request.headers['HTTP_CARD_NUMBER'] || request['headers']['card_number']
        cardpin = request.headers['HTTP_PIN'] || request['headers']['pin']

        account = Account.where(card_number: cardnum, pin: cardpin).first

        if account
          render json: { token: account.api_key.token }, status: 200
          LogEvent.call(account, 'Logged in successfully.')
        else
          render json: { message: 'Account not found' }, status: 401
        end
      end

      def index
        render json: { message: 'Resource not found' }, status: 404
      end

      def show
        LogEvent.call(@current_account, 'Displayed balance.')
      end

      def withdraw
        amount = params[:amount].to_i

        if @current_account.withdraw(amount)
          render json: { transaction_status: 'Success' }, status: 200
          LogEvent.call(@current_account, 'Withdrew money successfully.', amount)
        else
          fail_message = 'Failed - Insufficient funds' if amount > @current_account.balance_dollars
          fail_message = 'Failed - Invalid amount' if amount < 0
          render json: { transaction_status: fail_message }, status: 403
          LogEvent.call(@current_account, 'Withdraw money failed.', amount)
        end
      end
    end
  end
end
