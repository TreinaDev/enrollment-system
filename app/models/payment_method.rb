class PaymentMethod
  attr_reader :name, :code

  def self.all
    domain = Rails.configuration.api(:payment_fraud)
    response = Faraday.get("#{domain}/api/v1/payment_methods")

    return [] if response.status == 400

    json_response = JSON.parse(response.body, symbolize_names: true)
    json_response.map do |r|
      PaymentMethod.new(r)
    end
  end

  def initialize(name:, code:)
    @name = name
    @code = code
  end
end
