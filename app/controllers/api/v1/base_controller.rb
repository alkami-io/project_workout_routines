class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :api_user_sign_in
  before_action :require_login!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    return api_error(status: 404, errors: 'Not Found')
  end

  def require_login!
    return true if current_api_user.api_key.present?
    render json: { errors: [ { detail: 'Access Denied' } ] }, status: 401
  end

  def authenticate_token
    authenticate_with_http_token do |api_key, options|
       ApiUser.find_by(api_key: api_key)
    end
  end

  #
  ## ApiUser Signin
  def api_user_sign_in
    if params[:api_key].present? && !ApiUser.find_by_api_key(params[:api_key]).nil?
      sign_in(ApiUser.find_by_api_key(params[:api_key]), scope: :api_user)
    else
      render json: { errors: [ { detail: 'API Key invalid or missing' } ] }, status: 401
    end
  end
end
