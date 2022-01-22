class Author < ApplicationRecord
  has_many :pages
  has_many :sites, ->{distinct}, through: :pages
  validates_uniqueness_of :name
  
  def to_param
    "#{id}-#{name}" 
  end
end
