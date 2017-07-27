class Api::V1::RoutinesController < Api::V1::BaseController

  #
  ## GET api/v1/routines
  def index
    routines = Routine.all

    render json: routines
  end

  #
  ## GET api/v1/routines/1
  def show
    routine = Routine.find_by_id(params[:id])

    render json: routine
  end
end
