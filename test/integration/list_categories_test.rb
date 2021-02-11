require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(username: "johndoe", password: "password", 
                              email: "johndoe@example.com", admin: true)
    sign_in_as(@admin_user)
    @category = Category.create(name: "Miles")
    @category2 = Category.create(name: "Mileage")
  end

  test "should show categories listing" do
    get '/categories'
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
 