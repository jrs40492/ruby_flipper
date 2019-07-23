require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: {
        first_name: "",
        last_name: "",
        email: "fo@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    }
    assert_template 'users/edit'
    assert_select  "div.alert", "The form contains 5 errors."
  end

  test "successful edit with forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    first_name = "Foo"
    last_name = "bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {
      user: {
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: "",
        password_confirmation: ""
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name, @user.first_name
    assert_equal last_name, @user.last_name
    assert_equal email, @user.email
    log_in_as(@user)
    assert_redirected_to user_url(@user)
  end
end
