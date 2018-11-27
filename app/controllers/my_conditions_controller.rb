class MyConditionsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @my_conditions = MyCondition.where(user_id: current_user.id)
    @my_conditions_systemid = @my_conditions.pluck("systemid_for_calil")
  end
  
  def show
  end
  
  def create
    MyCondition.transaction do
      MyCondition.destroy_all(user_id: current_user.id)

      if params['my_conditions'].present?
        my_conditions_params.each do |param|
          MyCondition.create(param)
        end
      end
    end
    
    flash[:success] = '検索条件を登録しました。'
    redirect_to my_conditions_url
    return
    
    rescue => e
      flash.now[:danger] = '検索条件の登録に失敗しました。' + e.message
      render :index
  end
  
  def cities_select
    @cities = []
    @my_conditions_systemid = []
    if request.xhr?
      pref = params['pref']
      if pref.present?
        @my_conditions_systemid = MyCondition.where(user_id: current_user.id)
          .select("systemid_for_calil").pluck("systemid_for_calil")
        @cities = Calil::Library.find({pref: pref}).group_by { |item| item.systemid }
        @cities.reject! { |item| item.include?("Special") || item.include?("Univ") }
      end
    end
  end
  
  private

  def my_conditions_params
    params.require(:my_conditions).map do |param|
      ActionController::Parameters.new(param.to_hash).permit(
        :systemid_for_calil, :systemname_for_calil, :prefecture_name
      ).merge(user_id: current_user.id)
    end
  end
end
