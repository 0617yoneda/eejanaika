class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: ENV["MY_EMAIL"], subject: "お問い合わせ内容"
  end
end
