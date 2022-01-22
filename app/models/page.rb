class Page < ApplicationRecord
  belongs_to :site
  belongs_to :author
  has_many :page_categories
  has_many :categories, through: :page_categories
  
  has_rich_text :content

 validates_uniqueness_of :title, scope: :site
  
=begin 
  def zbody=(page_html)
    self.zbody = ActiveSupport::Gzip.compress(page_html)
  end
=end
  def body_content
    ActiveSupport::Gzip.decompress(self.zbody)
  end

    
  def to_param
    "#{id}-#{title}" 
  end
  
end
