class CostsController < ApplicationController
  def show
    cost_service = CostService.new(params[:weight])

    if cost_service.valid?
      route_service = RouteService.new(cost_params[:origin],
                                       cost_params[:destination])

      if route_service.valid?
        path = route_service.find_shortest
        cost = cost_service.calculate(path.distance)

        render json: { cost: cost }, status: 200
      else
        render json: route_service.errors, status: 400
      end
    else
      render json: cost_service.errors, status: 400
    end
  end

  private

  def cost_params
    params.permit(:origin, :destination, :weight)
  end
end
