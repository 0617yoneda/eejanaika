class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to root_path
    end
      redirect_to root_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :message, :email)
  end
end
