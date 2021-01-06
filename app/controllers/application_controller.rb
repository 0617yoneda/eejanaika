class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if customer_signed_in?
      posts_path(resource)
    else
      admins_posts_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
      root_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname,
      :profile_image_id,
      :crazy,
      :word
    ])
  end
end
