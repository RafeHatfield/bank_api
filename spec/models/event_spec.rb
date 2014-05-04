require 'spec_helper'

describe Event do
  it { should respond_to(:id) }
  it { should respond_to(:account_id) }
  it { should respond_to(:event) }
  it { should respond_to(:amount) }

  it { should respond_to(:account) }
end
