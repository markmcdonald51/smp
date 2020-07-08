class Category < ApplicationRecord
  validates_uniqueness_of :name
  has_many :page_categories
  has_many :pages, through: :page_categories
  
    
  def to_param
    "#{id}-#{name}" 
  end
  
end
