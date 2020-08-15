# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "ユーザーをフォローする" do
    franny = users(:one)
    zooey = users(:two)
    franny.follow(zooey)
    assert franny.following?(zooey)
  end

  test "ユーザーをアンフォローする" do
    franny = users(:one)
    zooey = users(:two)
    franny.follow(zooey)
    franny.unfollow(zooey)
    assert_not franny.following?(zooey)
  end

  test "パスワードなしでユーザー情報を変更する" do
    franny = users(:one)
    assert_equal users(:one).name, "Franny"
    franny.update_without_current_password(name: "フラニー")
    assert_equal users(:one).name, "フラニー"
  end

  test "GitHubアカウントでOAth認証する" do
    auth = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "12345",
      info: {
        name: "franny",
        email: "franny@example.com",
        password: "password" }
      })
    auth_user = User.from_omniauth(auth)
    franny = users(:one)
    assert auth_user == franny
  end
end
