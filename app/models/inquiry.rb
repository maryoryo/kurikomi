class Inquiry < ApplicationRecord
  
  attr_accessor :name, :email, :subject, :message

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true  
  validates :subject, presence: true  
  validates :message, presence: true  
end
