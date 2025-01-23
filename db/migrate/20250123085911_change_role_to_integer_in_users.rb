class ChangeRoleToIntegerInUsers < ActiveRecord::Migration[7.0]
  def up
    change_column_default :users, :role, nil
    
    execute "UPDATE users SET role = '0' WHERE role = 'user'"
    execute "UPDATE users SET role = '1' WHERE role = 'admin'"
    
    change_column :users, :role, :integer, using: 'role::integer'
    
    change_column_default :users, :role, 0
  end

  def down
    change_column_default :users, :role, nil
    change_column :users, :role, :string
    change_column_default :users, :role, 'user'
  end
end