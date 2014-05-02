class ApiKeysController < ApplicationController
  def create
    # generate_token
    ApiKey.create(api_key_params)
  end

  private

  def api_key_params
    params.require(:api_key).permit(:user, :token)
  end
end
