class InquiryMailer < ApplicationMailer

  def send_mail(inquiry)
    @inquiry = inquiry
    Rails.logger.info(">>>>> #{ENV['TOMAIL']}")
    mail to: ENV['TOMAIL'], subject: '【お問い合わせ】' + @inquiry.subject
  end
end
