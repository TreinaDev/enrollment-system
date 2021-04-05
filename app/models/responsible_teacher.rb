class ResponsibleTeacher
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def self.all
    domain = Rails.configuration.api['classroom_app']
    response = Faraday.get("#{domain}/all")

    return [] if response.status == 400

    json_response = JSON.parse(response.body, symbolize_names: true)
    json_response.map do |r|
      ResponsibleTeacher.new(r)
    end
  end
end
