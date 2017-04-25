class CostsController < ApplicationController
  def show
    cost_service = CostService.new(params[:weight])

    return render json: cost_service.errors, status: 400 unless cost_service.valid?

    path = RouteService.new(cost_params[:origin],
                            cost_params[:destination]).find_shortest

    render json: { cost: cost_service.calculate(path.distance) }, status: 200
  end

  private

  def cost_params
    params.permit(:origin, :destination, :weight)
  end
end
