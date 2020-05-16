# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end

  protected
    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end

    def after_sign_up_path_for(resource)
      user_path(id: current_user.id)
    end

    def after_update_path_for(resource)
      user_path(id: current_user.id)
    end
end
