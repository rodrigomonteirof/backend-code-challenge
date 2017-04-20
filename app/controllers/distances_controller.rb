class DistancesController < ApplicationController
  def create
    distance = Distance.find_or_create(distance_params[:origin],
                                       distance_params[:destiny])

    distance.kilometers = distance_params[:kilometers]

    if distance.valid? && distance.save
      render json: distance, status: 201
    else
      render json: distance.errors, status: 400
    end
  end

  private

  def distance_params
    params.permit(:origin, :destiny, :kilometers)
  end
end
