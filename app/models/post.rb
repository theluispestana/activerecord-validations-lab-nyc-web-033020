class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: ["Fiction", "Non-Fiction"] }
  validate :clickbait?

  def clickbait?
    if !self.check_title 
      errors.add(:title, "Needs more clickbait")
    end
  end

  def check_title
    if !self.title
      return false
    end

    split_title = self.title.split(' ')
    if self.title.include?("Won't Believe")
      return true
    elsif self.title.include?("Secret") 
      return true
    elsif self.title.include?("top") && split_title[1].is_integer?
      return true
    elsif self.title.include?("Guess")
      return true
    else
      return false
    end
  end
end
