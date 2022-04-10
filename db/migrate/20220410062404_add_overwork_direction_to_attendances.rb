class AddOverworkDirectionToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overwork_direction, :string
  end
end
