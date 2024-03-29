require 'spec_helper'
require 'api/api_helper'

describe 'Banking API' do

  before :each do
    FactoryGirl.create :account
  end

  it 'should return a single account with cardnumber and balance' do
    api_get "accounts/#{Account.last.id}", token: Account.last.api_key.token

    response.status.should eq 200

    account = JSON.parse(response.body)

    account['id'].should eq Account.last.id
    account['card_number'].should eq Account.last.card_number
    account['balance_dollars'].should eq Account.last.balance_dollars
  end

  it 'should correctly perform a withdrawal and return result of Success when balance allows' do
    initial_balance = Account.last.balance
    withdrawal_amount = 10

    api_put "accounts/withdraw/#{withdrawal_amount}", token: Account.last.api_key.token

    response.status.should eq 200

    Account.last.balance.should eq initial_balance - (withdrawal_amount.to_i * 100)

    payload = JSON.parse(response.body)
    payload['transaction_status'].should eq 'Success'
  end

  it 'should correctly return result of Failed when balance insufficient' do
    initial_balance = Account.last.balance
    withdrawal_amount = 100_000

    api_put "accounts/withdraw/#{withdrawal_amount}", token: Account.last.api_key.token

    response.status.should eq 403

    Account.last.balance.should eq initial_balance

    payload = JSON.parse(response.body)
    payload['transaction_status'].should eq 'Failed - Insufficient funds'
  end

  it 'should correctly return result of Failed when withdraw amount negative' do
    initial_balance = Account.last.balance
    withdrawal_amount = -10

    # api_put "accounts/#{Account.last.id}/withdraw/#{withdrawal_amount}", token: Account.last.api_key.token
    api_put "accounts/withdraw/#{withdrawal_amount}", token: Account.last.api_key.token

    response.status.should eq 403

    Account.last.balance.should eq initial_balance

    payload = JSON.parse(response.body)
    payload['transaction_status'].should eq 'Failed - Invalid amount'
  end

  it 'should correctly authenticate and return the token for a valid account' do
    api_post 'accounts/authenticate', headers: { 'card_number' => Account.last.card_number, 'pin' => Account.last.pin }

    response.status.should eq 200

    payload = JSON.parse(response.body)
    payload['token'].should eq Account.last.api_key.token
  end

  it 'should not correctly authenticate and return the token for an invalid account' do
    api_post 'accounts/authenticate', headers: { 'card_number' => '1234asdf', 'pin' => 1234 }

    response.status.should eq 401

    payload = JSON.parse(response.body)
    payload['message'].should eq 'Account not found'
  end
end
