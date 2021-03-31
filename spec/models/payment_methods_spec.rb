require 'rails_helper'

describe PaymentMethod do
  context 'Fetch API Data' do
    it 'should get all payment methods' do
      resp_json = File.read(Rails.root.join('spec/support/apis/get_payment_methods.json'))
      resp_double = double('faraday_resp', body: resp_json, status: 200)

      domain = Rails.configuration.api[:payment_fraud]
      allow(Faraday).to receive(:get).with("http://#{domain}/api/v1/payment_methods").and_return(resp_double)

      payment_methods = PaymentMethod.all

      expect(payment_methods.length).to eq 2
      expect(payment_methods.first.name).to eq 'Cartão de Crédito'
      expect(payment_methods.first.code).to eq 'CCARTAO'
      expect(payment_methods.last.name).to eq 'Boleto'
      expect(payment_methods.last.code).to eq 'BOLE'
    end

    it 'should return empty if bad request' do
      resp_double = double('faraday_resp', status: 400, body: '')
      domain = Rails.configuration.api[:payment_fraud]
      allow(Faraday).to receive(:get).with("http://#{domain}/api/v1/payment_methods").and_return(resp_double)

      payment_methods = PaymentMethod.all

      expect(payment_methods.length).to eq 0
    end
  end
end
