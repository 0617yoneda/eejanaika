class InquiryMailer < ApplicationMailer

  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: 'system@example.com',
      to:   ENV["MY_EMAIL"],
      subject: 'お問い合わせ通知'
    )
  end
end
