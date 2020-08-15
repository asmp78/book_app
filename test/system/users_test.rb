# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @relationship = relationships(:one)
  end

  test "ユーザーを一覧表示する" do
    sign_in @user
    visit users_path

    assert_selector "h1", text: "ユーザー一覧"
  end

  test "ユーザーを詳細表示する" do
    sign_in @user
    visit user_path(@user)

    assert_selector "h2", text: "プロフィール"
    click_on "戻る"
  end

  test "ユーザー情報を変更する" do
    sign_in @user
    visit edit_user_registration_path

    within "form[name=edit_user]" do
      fill_in "名前", with: "フラニー"
      fill_in "メールアドレス", with: "frannyfranny@example.com"
      fill_in "郵便番号", with: "1234567"
      fill_in "住所", with: "東京都"
      fill_in "自己紹介", with: "よろしくお願いします。"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（確認用）", with: "password"
      click_on "更新"
    end

    assert_text "アカウント情報を変更しました。"
    click_on "戻る"
  end

  test "ユーザー登録をする" do
    visit new_user_registration_path

    within "form[name=new_user]" do
      fill_in "名前", with: "フラニー"
      fill_in "メールアドレス", with: "frannyfranny@example.com"
      fill_in "郵便番号", with: "1234567"
      fill_in "住所", with: "東京都"
      fill_in "自己紹介", with: "よろしくお願いします。"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（確認用）", with: "password"
      click_on "アカウント登録"
    end

    assert_text "アカウント登録が完了しました。"
    click_on "戻る"
  end
end
