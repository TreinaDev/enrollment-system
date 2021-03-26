require 'rails_helper'

describe ResponsibleTeacher do
  context 'Fetch API Data' do
    it 'should get all responsible teachers' do
      json = File.read(Rails.root.join('spec/support/apis/get_responsible_teachers.json'))
      response = double('faraday_response', body: json, status: 200)
      allow(Faraday).to receive(:get).with('classroom-app.com/v1/api/all').and_return(response)
      responsible_teachers = ResponsibleTeacher.all

      expect(responsible_teachers.size).to eq 3
      expect(responsible_teachers[0].name).to eq('Renato Teixeira')
      expect(responsible_teachers[1].name).to eq('Izabela Marcondes')
      expect(responsible_teachers[2].name).to eq('Lucas Praça')
    end

    it 'should return empty if bad request' do
      resp_double = double('faraday_resp', status: 400, body: '')

      allow(Faraday).to receive(:get).with('classroom-app.com/v1/api/all').and_return(resp_double)
      responsible_teachers = ResponsibleTeacher.all

      expect(responsible_teachers.length).to eq 0
    end
  end
end
