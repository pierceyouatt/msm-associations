class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :characters, :name_string, :name
  end
end
