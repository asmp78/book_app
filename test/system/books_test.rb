# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @book = books(:one)
  end

  test "書籍を一覧表示する" do
    sign_in @user
    visit books_path

    assert_selector "h1", text: "書籍"
  end

  test "書籍を詳細表示する" do
    sign_in @user
    visit book_path(@book)

    assert_text "Franny and Zooey"
    click_on "戻る"
  end

  test "書籍を登録する" do
    sign_in @user
    visit new_book_path
    within "form[name=book]" do
      fill_in "タイトル", with: "The Catcher in the Rye"
      fill_in "メモ", with: "1951/7/16"
      fill_in "著者", with: "J.D.Salinger"
      click_on "登録"
    end

    assert_text "書籍の登録に成功しました。"
    click_on "戻る"
  end

  test "書籍を変更する" do
    sign_in @user
    visit edit_book_path(@book)
    within "form[name=book]" do
      fill_in "タイトル", with: "ライ麦場だけでつかまえて"
      fill_in "メモ", with: "1951年7月16日"
      fill_in "著者", with: "J.D.サリンジャー"
      click_on "更新"
    end

    assert_text "書籍の更新に成功しました。"
    click_on "戻る"
  end

  test "書籍を削除する" do
    sign_in @user
    visit books_path
    accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "書籍の削除に成功しました。"
  end
end
