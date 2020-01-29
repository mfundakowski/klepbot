class AddColumnsToContactActions < ActiveRecord::Migration[6.0]
  def change
    add_column :contact_actions, :body, :text
    add_column :contact_actions, :metadata, :text
    add_column :contact_actions, :status, :string
    add_column :contact_actions, :company_name, :string
    add_column :contact_actions, :phone_numbers, :text, array: true, null: false, default: []
    add_column :contact_actions, :websites, :text, array: true, null: false, default: []
    add_column :contact_actions, :possible_names, :text, array: true, null: false, default: []
  end
end
