class NotificationsController < ApplicationController
  before_action :authenticate_customer!
  def index
      @customer = current_customer
      @notifications = current_customer.passive_notifications
      @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to posts_path
  end
end
