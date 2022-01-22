class Site < ApplicationRecord
  has_many :pages
  has_many :authors, -> {distinct}, through: :pages
  validates_uniqueness_of :name
   
  def to_param
    "#{id}-#{name}" 
  end
end
