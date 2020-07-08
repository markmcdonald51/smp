class Author < ApplicationRecord
  validates_uniqueness_of :name
  
  
    
  def to_param
    "#{id}-#{name}" 
  end
end
