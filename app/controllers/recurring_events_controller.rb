class RecurringEventsController < ApplicationController
  def index
    @recurring_events = RecurringEvent.order(created_at: :desc)
      .paginate(page: params[:page], per_page: 50)
  end
  
  def new
    @recurring_event = RecurringEvent.new
  end
  
  def create
    @recurring_event = RecurringEvent.new(recurring_event_params)
    if @recurring_event.save
      flash[:success] = 'Recurring Event Created!'
      redirect_to recurring_events_path
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @recurring_event = RecurringEvent.find(params[:id])
    @recurring_event.destroy
    redirect_to recurring_events_path
  end
  
  private
    def recurring_event_params
      params.require(:recurring_event).permit(
        :name, :start_date, :interval_months, :day_of_month, :deliver_buffer_days
      )
    end
end
