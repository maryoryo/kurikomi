module Admin::GroupsHelper
  
  def render_with_hashtags(hashbody)
    hashbody.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) {|word| link_to word, "admin/groups/hashtag/#{word.delete("#")}"}.html_safe
  end
  
end
