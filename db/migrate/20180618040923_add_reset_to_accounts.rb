class AddResetToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :reset_digest, :string
    add_column :accounts, :reset_send_at, :datetime
  end
end
