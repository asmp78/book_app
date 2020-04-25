# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale, :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:name, :postcode, :address, :introduction]
      devise_parameter_sanitizer.permit :account_update, keys: [:name, :postcode, :address, :introduction]
    end
end
