class ApplicationController < ActionController::Base
  # # Prevent CSRF attacks by raising an exception.
  # # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  private

  def restrict_access
    unless restrict_access_by_params || restrict_access_by_header
      render json: { message: 'Invalid API Token' }, status: 401
      return
    end

    @current_account = @api_key.account if @api_key
  end

  def restrict_access_by_header
    return true if @api_key

    # httparty renames set header values; this should work around client not using it
    token = request.headers['HTTP_TOKEN'] || request['headers']['token']

    @api_key = ApiKey.find_by_token(token)

    # authenticate_with_http_token do |token|
    #   @api_key = ApiKey.find_by_token(token)
    # end
  end

  def restrict_access_by_params
    return true if @api_key

    @api_key = ApiKey.find_by_token(params[:token])
  end
end
