class PatientsController < ApplicationController
  before_action :authenticate_user!
    def index

      if params[:tag]
        Tag.create(name: params[:tag])
      end

      @patients= Patient.all
      if params[:tag_ids]
        @tweets = []
        params[:tag_ids].each do |key, value|
          if value == "1"
            tag_tweets = Tag.find_by(name: key).tweets
            @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
          end
      end
        @patients.uniq!
      end

      if params[:search] == nil
        @patients= Patient.all
      elsif params[:search] == ''
        @patients= Patient.all
      else
        @patients = Patient.where("body LIKE ? ",'%' + params[:search] + '%')
      end
      @patients = @patients.page(params[:page]).per(3)

      start_date = params.fetch(:start_date, Date.today).to_date
      events = Patient.where('start_time <= ? AND (end_time >= ? OR end_time IS NULL)', start_date.end_of_month.end_of_week, start_date.beginning_of_month.beginning_of_week)
    end

    def new
        @patient = Patient.new
    end

    def create
      patient = Patient.new(patient_params)
      patient.user_id = current_user.id
      if patient.save

        case patient.category
        when 'dog'
          redirect_to patient_dog_path
        when 'cat'
          redirect_to patient_cat_path
        when 'hadkadebanezumi'
          redirect_to patient_hadakadebanezumi_path
        else
          redirect_to users_path, notice: 'Post was successfully created, but the category was not recognized.'
        end
      else
        redirect_to :action => "new"
      end
    end

    def show
      @patient = Patient.find(params[:id])
      @comments = @patient.comments
      @comment = Comment.new
    end

    def edit
      @patient = Patient.find(params[:id])
    end

    def update
      patient = Patient.find(params[:id])
      if patient.update(patient_params)
        redirect_to :action => "show", :id => patient.id
      else
        redirect_to :action => "new"
      end
    end

    def destroy
      patient = Patient.find(params[:id])
      patient.destroy
      redirect_to action: :index
    end

    def dog
      @patients = Patient.all
      start_date = params.fetch(:start_date, Date.today).to_date
      @events = Patient.where('start_time <= ? AND (end_time >= ? OR end_time IS NULL)', start_date.end_of_month.end_of_week, start_date.beginning_of_month.beginning_of_week)
      @events = @events.where(category:"dog") #ここがポイント！categoryのバリューがdogの投稿を取得！
    end

    def cat
      @patients = Patient.all
      start_date = params.fetch(:start_date, Date.today).to_date
      @events = Patient.where('start_time <= ? AND (end_time >= ? OR end_time IS NULL)', start_date.end_of_month.end_of_week, start_date.beginning_of_month.beginning_of_week)
      @events = @events.where(category:"cat") #ここがポイント！categoryのバリューがdogの投稿を取得！
    end
  
    def hadakadebanezumi
      @patients = Patient.all
      start_date = params.fetch(:start_date, Date.today).to_date
      @events = Patient.where('start_time <= ? AND (end_time >= ? OR end_time IS NULL)', start_date.end_of_month.end_of_week, start_date.beginning_of_month.beginning_of_week)
      @events = @events.where(category:"hadakadebanezumi") #ここがポイント！categoryのバリューがdogの投稿を取得！
    end

    private
    def patient_params
      params.require(:patient).permit(:event, :inner, :outer, :review, :image, :star, :start_time, :end_time, :category, tag_ids: [])
    end
end
