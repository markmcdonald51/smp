class Site < ApplicationRecord
  has_many :pages
  validates_uniqueness_of :name
   
  def to_param
    "#{id}-#{name}" 
  end
end
