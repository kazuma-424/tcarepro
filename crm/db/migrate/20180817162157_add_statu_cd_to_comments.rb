class AddStatuCdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :status_cd, :integer, :default => 0
  end
end
