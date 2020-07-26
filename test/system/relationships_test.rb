# frozen_string_literal: true

require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @other = users(:two)
  end

  test "ユーザーをフォローする" do
    sign_in @user
    visit user_path(@other)

    click_button "フォロー"
    assert_text "1 フォロー"
    click_on "戻る"
  end

  test "ユーザーをフォロー解除する" do
    sign_in @user
    visit user_path(@other)

    click_button "フォロー"
    click_button "フォロー解除"
    assert_text "0 フォロワー"
    click_on "戻る"
  end

  test "フォロー一覧を表示する" do
    sign_in @user
    visit user_followings_path(@user)

    assert_selector "h2", text: "Frannyのフォロー"
    click_on "戻る"
  end

  test "フォロワー一覧を表示する" do
    sign_in @user
    visit user_followers_path(@user)

    assert_selector "h2", text: "Frannyのフォロワー"
    click_on "戻る"
  end
end
