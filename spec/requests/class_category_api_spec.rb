require 'rails_helper'

describe 'Class Category API' do
  context '#show' do
    it 'succesfully' do
      class_category = create(:class_category)
      class_category.icon.attach(io: File.open(Rails.root.join('spec/support/yoga_icon.jpg')),
                                 filename: 'yoga_icon.jpg')

      get api_v1_class_category_path(class_category.id)
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[:name]).to eq('Crossfit')
      expect(json_response[:description]).to eq('Fica grande')
      expect(json_response[:responsible_teacher]).to eq('Felipe Franco')
      expect(json_response[:image_url]).to eq('http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBZ3ciLCJleHAiOm51bGwsInB1ciI6ImJsb2JfaWQifX0=--86fbdf4cd6e50b8d6469dfebee67a3825e52e6f3/yoga_icon.jpg')
    end

    it 'unhappy path' do
      get api_v1_class_category_path(2)

      expect(response).to have_http_status(404)
    end
  end

  context '#index' do
    it 'succesfully' do
      create(:class_category)
      create(:class_category, name: 'Yoga', description: 'Aula zen', responsible_teacher: 'Mudra')
      create(:class_category, name: 'Boxe', description: 'Soco soco, bate bate', responsible_teacher: 'Popó')

      get api_v1_class_categories_path
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[0][:name]).to eq('Crossfit')
      expect(json_response[0][:description]).to eq('Fica grande')
      expect(json_response[0][:responsible_teacher]).to eq('Felipe Franco')
      expect(json_response[1][:name]).to eq('Yoga')
      expect(json_response[1][:description]).to eq('Aula zen')
      expect(json_response[1][:responsible_teacher]).to eq('Mudra')
      expect(json_response[2][:name]).to eq('Boxe')
      expect(json_response[2][:description]).to eq('Soco soco, bate bate')
      expect(json_response[2][:responsible_teacher]).to eq('Popó')
    end

    it 'should return error if dont find class categories' do
      get api_v1_class_categories_path

      expect(response).to have_http_status(404)
    end
  end
end
