require 'spec_helper'

describe Account do
  it { should respond_to(:id) }
  it { should respond_to(:card_number) }
  it { should respond_to(:pin) }
  it { should respond_to(:balance) }

  it { should respond_to(:balance_dollars) }
  it { should respond_to(:api_key) }

  let(:account) { FactoryGirl.build_stubbed(:account) }

  subject { account }

  it { should be_valid }

  describe 'when card_number is not present' do
    before { account.card_number = ' ' }
    it { should_not be_valid }
  end

  describe 'when pin is not present' do
    before { account.pin = ' ' }
    it { should_not be_valid }
  end

  describe 'when balance converted to dollars' do
    before { account.balance = rand(0..100_000) }
    # it { account.balance_dollars eq 20 }
    it 'shoud show correct dollar amount' do
      account.balance_dollars.should eq account.balance / 100
    end
  end


end
