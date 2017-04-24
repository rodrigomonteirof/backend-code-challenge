class DistancesController < ApplicationController
  def create
    distance = Distance.find_or_create_by(origin: params[:origin],
                                          destination: params[:destination])

    distance.kilometers = distance_params[:kilometers]

    if distance.valid? && distance.save
      render json: distance, status: 201
    else
      render json: distance.errors, status: 400
    end
  end

  private

  def distance_params
    params.permit(:origin, :destination, :kilometers)
  end
end
