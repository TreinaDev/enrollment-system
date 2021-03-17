require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  context 'create enrollment' do
    # it { should belong_to(:customer) }

    it '#hire_plan!' do
      customer = create(:customer)
      plan = create(:plan)
      enrollment = create(:enrollment, customer: customer)

      enrollment.hire_plan!(plan)

      expect(enrollment.plan).to eq plan
      expect(customer.plan).to eq plan
    end
  end
end
