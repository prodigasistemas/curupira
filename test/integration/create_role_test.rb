require "test_helper"

class CreateRoleTest < ActionDispatch::IntegrationTest

  test "create a new role" do
    get new_role_path

    assert_response :success

    post_via_redirect roles_path, role: { name: "Admin" }

    assert_equal roles_path, path

    assert_equal 'Role created successfully', flash[:notice]
  end
end
