require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    def setup
        @category = Category.new(name: "Sports")
    end
    
    test "Category should be valid" do
        assert @category.valid?
    end

    test "name should be present" do
        @category.name = " "
        assert_not @category.valid?
    end

    test "name should be unique" do
        @category.save
        @category2 = Category.new(name: "Sports")
        assert_not @category2.valid? 
    end

    test "name should be max 25 xters" do
        @category.name = "a" * 28
        assert_not @category.valid?
    end

    test "name should be min 3 xters" do
        @category.name = "aa"
        assert_not @category.valid?
    end

end