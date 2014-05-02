require 'spec_helper'

describe ApiKey do
  it { should respond_to(:id) }
  it { should respond_to(:account_id) }
  it { should respond_to(:token) }

  it { should respond_to(:account) }

  let(:api_key) { FactoryGirl.build_stubbed(:api_key) }

  subject { api_key }

  describe 'ApiKey data' do
    it 'is valid with account and token' do
      expect(api_key).to be_valid
    end

    it 'is invalid without an account' do
      api_key.account = nil
      expect(api_key).to have(1).errors_on(:account)
    end

    it 'is invalid without a token' do
      api_key.token = nil
      expect(api_key).to have(1).errors_on(:token)
    end
  end
end
