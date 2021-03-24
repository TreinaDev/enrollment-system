class CurrentUser
  attr_reader :email, :status

  def initialize(email:, status:)
    @email = email
    @status = status
  end

  def self.login
    response = Faraday.get('classroom-app.com/v1/api/all')

    json_response = JSON.parse(response.body, symbolize_names: true)
    CurrentUser.new(email: json_response[:email], status: json_response[:status])
  end
end