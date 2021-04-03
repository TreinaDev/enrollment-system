class AddEnrolledAtOnEnrollments < ActiveRecord::Migration[6.1]
  def change
    add_column :enrollments, :enrolled_at, :date
  end
end
