class PaymentMethod
  attr_reader :name, :code

  def self.all
    response = Faraday.get('paymentmethods.com/v1/api/all')
    return [] if response.status == 400
    json_response = JSON.parse(response.body, symbolize_names: true)
    payment_methods = []
    json_response.map do |r|
      PaymentMethod.new(r)
    end
  end

  def initialize(name:, code:)
    @name = name
    @code = code
  end
end