class InquiryMailer < ApplicationMailer

  def send_mail(inquiry)
    @inquiry = inquiry
    mail to: ENV['TOMAIL'], subject: '【お問い合わせ】' + @inquiry.subject_i18n
  end

end
