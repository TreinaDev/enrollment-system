module Api
  module V1
    class PlansController < ApiController
      def index
        plans = Plan.all
        render json: plans.as_json(except: [:created_at, :updated_at], 
                                      include: {
                                              class_categories: {only: [:id, :name]}
                                            })
      end
    end
  end
end