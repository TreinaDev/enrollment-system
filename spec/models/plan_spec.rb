require 'rails_helper'

describe Plan do
  context 'validation' do
    it 'fields cannot be empty' do
      plan = Plan.create(name: '',
                         description: '',
                         monthly_rate: '',
                         monthly_class_limit: '')

      expect(plan.valid?).to eq false
      expect(plan.errors[:name]).to include 'não pode ficar em branco'
      expect(plan.errors[:description]).to include 'não pode ficar em branco'
      expect(plan.errors[:monthly_rate]).to include 'não pode ficar em branco'
      expect(plan.errors[:monthly_class_limit]).to include 'não pode ficar em branco'
    end
    it 'name must be unique' do
      create(:plan, name: 'Basico')
      plan = Plan.create(name: 'Basico')
      expect(plan.errors[:name]).to include 'já está em uso'
    end
    it 'monthly rate must be greater than 0' do
      yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
      crossfit = create(:class_category, name: 'Crossfit')
      plan = Plan.create(name: 'Fit',
                         description: 'Ideal para quem está começando',
                         monthly_rate: 0,
                         monthly_class_limit: 10,
                         class_categories: [crossfit, yoga])
      expect(plan.errors[:monthly_rate]).to include('deve ser maior que 0')
      expect(Plan.all.count).to eq 0
    end
    it 'monthly class limit must be greater than 0' do
      yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
      crossfit = create(:class_category, name: 'Crossfit')
      plan = Plan.create(name: 'Fit',
                         description: 'Ideal para quem está começando',
                         monthly_rate: 10.50,
                         monthly_class_limit: 0,
                         class_categories: [crossfit, yoga])
      expect(plan.errors[:monthly_class_limit]).to include('deve ser maior que 0')
      expect(Plan.all.count).to eq 0
    end
  end
end
