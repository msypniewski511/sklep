require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "product attributes must be not empty!" do
  	product = Product.new
  	assert_not product.valid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:image_url].any?
  	assert product.errors[:price].any?
  end

  test "product price must be positive" do
  	product = Product.new(title: 'tytul', description: 'Opis', image_url: 'plik.jpg')
  	assert !product.valid?
  	product.price = -1
  	assert product.invalid?
  	assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

  	product.price = 0
  	assert product.invalid?
  	assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	Product.new(title: 'tytul', description: 'opis', price: 1, :image_url => image_url)
  end

  test "product image should have valid extensions" do
  	ok = %w{maciej.gif xxx.gif xxx.png XXX.JPG XXX.PNG XXX.GIF}
  	bad = %w{xxx.doc xxx.gif.more}
  	ok.each do |url| 
  	  assert new_product(url).valid?
  	end

  	bad.each do |url|
  		assert !new_product(url).valid?
  	end
  	
  end

  test "the title of product should be unique" do
  	product = Product.new(title: products(:ruby).title,
  		description: 'opis',
  		image_url: 'xxx.jpg',
  		price: 10.0)
  	assert !product.save
  end
end
