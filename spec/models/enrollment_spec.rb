require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to(:plan) }
end
