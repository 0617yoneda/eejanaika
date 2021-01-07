class NotificationsController < ApplicationController
  def index
    @notifications = current_customer.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
  end
end
