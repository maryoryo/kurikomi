class Genre < ApplicationRecord
  
  has_many :groups
  
  validates :name, presence: true
  
  
  def self.search_for(content, method)
    if method == 'perfect'
      Genre.where(name: content)
    elsif method == 'forword'
      Genre.where('name LIKE ?', content + '%')
    elsif method == 'backword'
      Genre.where('name LIKE ?', '%' + content)
    else
      Genre.where('name LIKE ?', '%' + content + '%')
    end
  end
  
end
