class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_education_degree, :string
  end
end
