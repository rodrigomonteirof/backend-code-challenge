class CostsController < ApplicationController
  def show
    cost_service = CostService.new(cost_params[:weight])

    return render json: cost_service.errors, status: :unprocessable_entity unless cost_service.valid?

    path = RouteService.new(cost_params[:origin],
                            cost_params[:destination]).find_shortest_path

    if path.present?
      render json: { cost: cost_service.calculate(path.distance) }, status: :ok
    else
      render json: { error: 'Path not found' }, status: :not_found
    end
  end

  private

  def cost_params
    params.permit(:origin, :destination, :weight)
  end
end
