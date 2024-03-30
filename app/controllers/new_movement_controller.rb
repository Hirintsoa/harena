class NewMovementController < ApplicationController
  def base_step
    session[:movement_type] = params[:type]&.classify if request.get?

    if request.post?
      @activity = Activity.find(params[:activity_id])

      if %w[ immediate delayed ].include? params[:period].downcase
        if params[:period].downcase.eql? 'immediate'
          OneTimeMovementCreationJob.perform_now(**job_attrs)
          flash[:notice] = "#{session[:movement_type].capitalize} created successfully"
        else
          OneTimeMovementCreationJob.set(wait_until: (params[:execution_time].to_datetime + 6.hours)).perform_later(**job_attrs)
          flash[:notice] = "#{session[:movement_type].capitalize} scheduled successfully for #{params[:execution_time].to_date.to_fs(:long_ordinal)}"
        end

        redirect_to @activity
      else
        session[:movement] = Movement.new(base_params.merge(type: session[:movement_type], activity_id: @activity.id))
        render 'new_movement/configuration_step'
      end
    end
  end

  def configuration_step
    # @movement ||= Movement.find(params[:movement_id])
    if request.post?
      @configuration = Configuration.create!(config_attrs)
      flash[:notice] = "Recurring #{session.fetch(:movement_type)} saved."

      render Activity.find(params[:activity_id])
    end
  end

  def tag
    template = helpers.public_send("#{tag_params[:type]}_select_tag")
    render inline: template
  end

  private

  def config_attrs
    configuration_params.merge(
                                name: session.dig(:movement, :name),
                                amount: session.dig(:movement, :amount),
                                range_amount: params[:range_amount] || 1,
                                activity_id: params.fetch(:activity_id)
                              )
  end

  def job_attrs
    recipient = Activity.find(params[:activity_id]).accounts.ids
    recipient.delete(current_account.id)
    {
      attributes: base_params.merge(type: session[:movement_type], activity_id: params[:activity_id]),
      recipient:,
      message: "New #{session[:movement_type].downcase} created: #{base_params[:name]}."
    }
  end

  def base_params
    params.permit(:name, :description, :amount)
  end

  def configuration_params
    params.permit(:base, :automatic)
  end

  def tag_params
    params.require(:tag).permit(:type, :order)
  end
end
