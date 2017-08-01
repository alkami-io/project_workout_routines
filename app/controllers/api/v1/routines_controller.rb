class Api::V1::RoutinesController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token

  #
  ## GET api/v1/routines
  def index
    routines = Routine.where(user_id: params[:user_id])

    render json: routines
  end

  #
  ## GET api/v1/routines/1
  def show
    routine = Routine.find_by_id(params[:id])

    render json: routine
  end

  #
  ## POST api/v1/routines/
  def create
    routine = Routine.create(
       name: params[:name],
                focus: params[:focus].to_i,
                user_id: params[:user_id].to_i)

    if routine.save
      render json: {status: 201}
    else
      render json: routine.errors, status: :unprocessable_entity
    end
  end

end
