class Public::InquiriesController < ApplicationController
  
  def index
    @inquiry = Inquiry.new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to thanks_path
    else
      render :new
    end
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
  end

  def thanks
  end
  
  
  private
  
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :subject, :message)
  end
end
