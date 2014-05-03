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
        else
          render json: { message: 'Account not found' }, status: 401
        end
      end

      def index
        render json: { message: 'Resource not found' }, status: 404
      end

      def show
      end

      def withdraw
        amount = params[:amount].to_i

        if @current_account.withdraw(amount)
          render json: { transaction_status: 'Success' }, status: 200
        else
          render json: { transaction_status: 'Failed - Insufficient funds' }, status: 403 if amount > @current_account.balance_dollars
          render json: { transaction_status: 'Failed - Invalid amount' }, status: 403 if amount < 0
        end
      end
    end
  end
end
