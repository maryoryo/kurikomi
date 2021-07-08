class Genre < ApplicationRecord
  
  has_many :groups
  
  def self.search_for(content,method)
    if method == 'perfect'
      User.where(genre: content)
    elsif method == 'forword'
      User.where('genre LIKe ?', content + '%')
    elsif method == 'backword'
      User.where('genre LIKE ?', '%' + content)
    else
      User.where('genre LIKE ?', '%' + content + '%')
    end
  end
  
end
