# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @report = reports(:one)
    @comment = comments(:one)
  end

  test "コメント一覧表示する" do
    sign_in @user
    visit report_path(@report)

    assert_selector "h2", text: "コメント"
  end

  test "コメントを登録する" do
    sign_in @user
    visit report_path(@report)

    within "form[name=comment]" do
      fill_in "内容", with: "コメントできた"
      click_on "登録"
    end

    assert_text "コメントの登録に成功しました。"
    click_on "戻る"
  end

  test "コメントを更新する" do
    sign_in @user
    visit edit_report_comment_path(@report, @comment)
    within "form[name=comment]" do
      fill_in "内容", with: "コメントできた！"
      click_on "更新"
    end

    assert_text "コメントの更新に成功しました。"
    click_on "戻る"
  end

  test "コメントを削除する" do
    sign_in @user
    visit report_path(@report)
    accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "コメントの削除に成功しました。"
  end
end
