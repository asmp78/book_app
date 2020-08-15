# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @report = reports(:one)
  end

  test "日報を一覧表示する" do
    sign_in @user
    visit reports_path

    assert_selector "h1", text: "日報"
  end

  test "日報を詳細表示する" do
    sign_in @user
    visit report_path(@report)

    assert_text "フォロー機能を追加"
    click_on "戻る"
  end

  test "日報を作成する" do
    sign_in @user
    visit new_report_path
    within "form[name=report]" do
      fill_in "タイトル", with: "コメント機能を追加"
      fill_in "内容", with: "コメント機能を追加した。"
      click_on "登録"
    end

    assert_text "日報の登録に成功しました。"
    click_on "戻る"
  end

  test "日報を変更する" do
    sign_in @user
    visit edit_report_path(@report)
    within "form[name=report]" do
      fill_in "タイトル", with: "日報機能を追加"
      fill_in "内容", with: "日報機能を追加しました。"
      click_on "更新"
    end

    assert_text "日報の更新に成功しました。"
    click_on "戻る"
  end

  test "日報を削除する" do
    sign_in @user
    visit reports_path
    accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "日報の削除に成功しました。"
    assert_no_text "フォロー機能を追加"
  end
end
