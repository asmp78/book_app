# frozen_string_literal: true

class AddUserIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :user, foreign_key: true
  end
end
