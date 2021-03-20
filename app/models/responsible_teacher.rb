class ResponsibleTeacher
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def self.all
    response = Faraday.get('classroom-app.com/v1/api/all')

    return [] if response.status == 400

    json_response = JSON.parse(response.body, symbolize_names: true)
    json_response.map do |r|
      ResponsibleTeacher.new(r)
    end
  end
end