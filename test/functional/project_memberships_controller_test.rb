require 'test_helper'

class ProjectMembershipControllerTest < ActionController::TestCase
  test "should get project:references" do
    get :project:references
    assert_response :success
  end

  test "should get role:string" do
    get :role:string
    assert_response :success
  end

  test "should get user:references" do
    get :user:references
    assert_response :success
  end

end
