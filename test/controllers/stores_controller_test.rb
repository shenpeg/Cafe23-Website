require "test_helper"

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @store = FactoryBot.create(:store)
  end

  test "should get index" do
    get stores_path
    assert_response :success
    assert_not_nil assigns(:active_stores)
    assert_not_nil assigns(:inactive_stores)
  end

  test "should show store" do
    get store_path(@store)
    assert_response :success
    assert_not_nil assigns(:current_employees)
  end

  test "should get new" do
    get new_store_path
    assert_response :success
  end

  test "should create store" do
    # create works
    assert_difference('Store.count') do
      post stores_path, params: { store: { name: 'North Hills', street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    end
    assert_redirected_to store_path(Store.last)

    # create fails
    post stores_path, params: { store: { name: nil, street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    assert_template :new
  end

  test "should get edit" do
    get edit_store_path(@store)
    assert_response :success
  end

  test "should update store" do
    # update works
    patch store_path(@store), params: { store: { name: 'North Hills', street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    assert_equal "Updated store information for North Hills.", flash[:notice]
    assert_redirected_to store_path(@store)

    # update fails
    patch store_path(@store), params: { store: { name: nil, street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    assert_template :edit
  end

  test "should be no destroy action for store" do
    assert_raise ActionController::UrlGenerationError do get url_for(controller: "stores", action: "destroy", id: "#{@store.id}") end
  end

end
