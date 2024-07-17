# frozen_string_literal: true

class AddDeviseToCustomers < ActiveRecord::Migration[6.1]
  def change
    change_table :customers do |t|
      ## Database authenticatable
      # t.string :email,              null: false, default: ""  # Comment out this line
      # t.string :encrypted_password, null: false, default: ""  # Comment out this line

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # Uncomment these if you need tracking fields
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # Uncomment these if you want confirmable functionality
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # Uncomment these if you want lockable functionality
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # If timestamps are not present in the table, uncomment the following line
      # t.timestamps null: false
    end

    # Add indexes only if they are not already present
    add_index :customers, :reset_password_token, unique: true
    # add_index :customers, :confirmation_token,   unique: true
    # add_index :customers, :unlock_token,         unique: true
  end
end
