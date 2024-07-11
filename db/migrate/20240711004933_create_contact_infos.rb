class CreateContactInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_infos do |t|
      t.string :phone
      t.string :address
      t.string :open_hours
      t.string :email

      t.timestamps
    end
  end
end
