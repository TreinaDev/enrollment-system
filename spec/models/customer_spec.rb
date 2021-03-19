require 'rails_helper'

RSpec.describe Customer, type: :model do
  context '#hire_plan!' do
    it 'creates enrollment' do
      customer = create(:customer)
      plan = create(:plan)

      resp_json = '{ "blocked": false }'
      resp_double = double('faraday_response', status: :ok, body: resp_json)
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("API/#{customer.cpf}")
                                                                 .and_return(resp_double)

      customer.hire_plan!(plan)

      expect(customer.enrollment).to be_truthy
      expect(customer.enrollment.plan).to eq plan
      expect(customer.enrollment.status).to eq 'active'
    end

    it 'requires a plan' do
      customer = create(:customer)

      resp_json = '{ "blocked": false }'
      resp_double = double('faraday_response', status: :ok, body: resp_json)
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("API/#{customer.cpf}")
                                                                 .and_return(resp_double)
      customer.hire_plan!(nil)

      expect(customer.enrollment.errors.count).to eq 1
      expect(customer.enrollment.errors.full_messages).to include 'Plan é obrigatório(a)'
    end

    it 'change plan if already has one' do
      first_plan = create(:plan)
      new_plan = create(:plan, name: 'Avançado')
      customer = create(:customer)
      create(:enrollment, customer: customer, plan: first_plan)

      resp_json = '{ "blocked": false }'
      resp_double = double('faraday_response', status: :ok, body: resp_json)
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("API/#{customer.cpf}")
                                                                 .and_return(resp_double)

      customer.hire_plan!(new_plan)

      expect(customer.enrollment.plan).to eq new_plan
    end

    it 'does not create if cpf is blocked' do
      plan = create(:plan)
      customer = create(:customer)

      resp_json = '{ "blocked": true }'
      resp_double = double('faraday_response', status: :ok, body: resp_json)
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("API/#{customer.cpf}")
                                                                 .and_return(resp_double)

      customer.hire_plan!(plan)

      expect(customer.enrollment).to eq nil
      expect(customer.errors.count).to eq 1
    end
  end
end
