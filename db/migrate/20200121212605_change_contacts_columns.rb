class ChangeContactsColumns < ActiveRecord::Migration[6.0]
  def change
    change_column_null :contacts, :first_name, true
    change_column_null :contacts, :last_name, true
    change_column_null :contacts, :email, true
    add_column :contacts, :body, :text
    add_column :contacts, :metadata, :text
    add_column :contacts, :status, :string, null: false, default: 'pending'
    add_column :contacts, :company_name, :string
    add_column :contacts, :phone_numbers, :text, array: true, null: false, default: []
    add_column :contacts, :websites, :text, array: true, null: false, default: []
    add_column :contacts, :possible_names, :text, array: true, null: false, default: []
  end
end
