class Page < ApplicationRecord
  belongs_to :site
  belongs_to :author
  has_many :page_categories
  has_many :categories, through: :page_categories
  
  has_rich_text :content
  
    
  def to_param
    "#{id}-#{title}" 
  end
  
end
