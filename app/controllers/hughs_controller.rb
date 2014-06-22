class HughsController < ApplicationController
  respond_to :json

  def create
    hugh = Hugh.new create_params
    if hugh.valid?
      hugh.save
      respond_with hugh, root: false
    else
      render json: { errors: hugh.errors.to_h }, status: :unprocessible_entity
    end
  end

  private
  def create_params
    params.permit :spark_core_id, :spark_api_access_token
  end
end
