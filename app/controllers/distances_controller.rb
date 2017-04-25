class DistancesController < ApplicationController
  def create
    distance = Distance.find_or_create_by(origin: distance_params[:origin],
                                          destination: distance_params[:destination])

    distance.kilometers = distance_params[:kilometers]

    if distance.valid? && distance.save
      render json: distance, status: :created
    else
      render json: distance.errors, status: :unprocessable_entity
    end
  end

  private

  def distance_params
    params.permit(:origin, :destination, :kilometers)
  end
end
