class AddCurrentSessionIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :current_session_id, :string
  end
end
