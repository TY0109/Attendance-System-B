class AddOverworkDirectorToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overwork_director, :string
  end
end
