# frozen_string_literal: true

class ChangeRportsUserNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :reports, :user_id, false
  end
end
