class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
		:with => /\.(gif|jpg|png)\z/i,
		:message => 'must be URL for GIF, JPG or PNG file'
  }

	
  # Metoda wykorzystana w cachingu.
  def self.latest
	Product.order(:updated_at).latest
  end
  private
	
  def ensure_not_referenced_by_any_line_item
	unless line_items.empty?
	  errors.add(:base, 'Line Item present')
	  throw :abort
	end
  end
end
