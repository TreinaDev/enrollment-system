class ChangeMonthlyRateInPlans < ActiveRecord::Migration[6.1]
  def change
    rename_column(:plans, :montlhy_rate, :monthly_rate)
  end
end
