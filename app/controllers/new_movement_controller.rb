class NewMovementController < ApplicationController
  def base_step
    session[:movement_type] = params[:type]&.classify if request.get?

    if request.post?
      @movement = Movement.new(base_params.merge(type: session[:movement_type], activity_id: params[:activity_id]))

      if %w[ immediate delayed ].include? params[:period].downcase
        if params[:period].downcase.eql? 'immediate'
          OneTimeMovementCreationJob.perform(**job_attrs)
        else
          OneTimeMovementCreationJob.set(wait_until: (params[:execution_time].to_datetime + 6.hours)).perform_later(**job_attrs)
        end

        render @movement
      else
        session[:movement] = @movement
        render 'new_movement/configuration_step'
      end
    end
  end

  def configuration_step
    # @movement ||= Movement.find(params[:movement_id])
    if request.post?
      @configuration = Configuration.new(configuration_params.merge(activity_id: params[:activity_id]))

      render Activity.find(params[:activity_id])
    end
  end

  def tag
    template = helpers.public_send("#{tag_params[:type]}_select_tag", tag_params[:order])
    render inline: template
  end

  private

  def job_attrs
    {
      record: @movement,
      recipient: @activity.accounts.delete(current_account),
      message: "New #{@type.downcase}created: #{base_params[:name]}."
    }
  end

  def base_params
    params.permit(:name, :description, :amount)
  end

  def configuration_params
    params.permit(:name, :base, :range_amount, :amount, :automatic)
  end

  def tag_params
    params.require(:tag).permit(:type, :order)
  end
end
