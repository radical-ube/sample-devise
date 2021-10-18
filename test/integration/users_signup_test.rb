require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  setup do
    @invalid_params = { user: { name: '',
                                email: 'user@invalid',
                                password: 'foo',
                                password_confirmation: 'bar' } }

    @valid_params = { user: { name: 'foo bar',
                              email: 'user@valid.com',
                              password: 'foobar',
                              password_confirmation: 'foobar' } }
  end

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: @invalid_params
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: @valid_params
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
