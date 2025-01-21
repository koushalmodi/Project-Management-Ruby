class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_active_storage_url_options

  private

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = { host: request.base_url }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

  def find_user
    begin
      request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      @current_user = User.find(jwt_payload['sub'])
    rescue
      return render json: {errors: {message:"please login again"}}, status: :unauthorized
    end
  end
end
