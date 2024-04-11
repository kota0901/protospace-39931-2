class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 新規登録(sign_up)の際に、name, profile, occupation, positionパラメータを許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])

    # アカウント更新(account_update)の際にも同様に許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :occupation, :position])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
