class HughsController < ApplicationController
  respond_to :json

  def show
    hugh = Hugh.find params[:id]
    respond_with hugh, root: false
  end

  def create
    hugh = Hugh.new create_params
    if hugh.valid?
      hugh.save
      respond_with hugh, root: false
    else
      render json: { errors: hugh.errors.to_h }, status: :unprocessible_entity
    end
  end

  def update
    hugh = Hugh.find params[:id]
    if hugh.wink_user_id == current_wink_user_id
      hugh.update update_params
      respond_with hugh
    else
      render json: { errors: "Unauthorized"}, status: :unauthorized
    end
  end

  def destroy
    hugh = Hugh.find params[:id]
    if hugh.wink_user_id == current_wink_user_id
      hugh.destroy
      respond_with hugh
    else
      render json: { errors: "Unauthorized"}, status: :unauthorized
    end
  end

  private
  def create_params
    params.permit(:spark_core_id, :spark_api_access_token).merge(wink_user_id: current_wink_user_id)
  end

  def update_params
    params.permit :color, :brightness
  end
end
