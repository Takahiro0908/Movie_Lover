# migration ファイルでdefault値に1を追加
class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :status, from: nil, to: "1"
  end
end