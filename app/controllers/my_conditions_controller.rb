class MyConditionsController < ApplicationController
  
  def index
    gon.calil_app_key = ENV['CALIL_APP_KEY']
    @title = params[:title]
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
  end
  
  def create
    @my_conditions = MyCondition.new(my_conditions_params)
    
    #if @my_conditions.save
      flash[:success] = '検索条件を登録しました。'
      redirect_to @my_conditions
    #else
      #flash.now[:danger] = '検索条件の登録に失敗しました。'
      render :index
    #end
  end
  
  def library_search
    
    if request.xhr?
      systemid_list = params["systemid_list"]
      @city = params["city"]
      
      @libraries = []
      
      if systemid_list.present?
        # いったん専門と大学は除く
        systemid_list.reject! {|systemid| systemid.include?("Special") || systemid.include?("Univ")}
        
        systemid_list.each do |systemid|
          @libraries = Calil::Library.find(systemid: systemid)
          
          #@libraries << libraries

        end
      end
    end
  end
  
  private
  
  
# user_id
# systemid_for_calil
# libid_for_calil

# libname_for_calil 

  def my_conditions_params
    binding.pry
    params.require(:my_conditions).map { |u| u.permit([:systemid_for_calil], [:libid_for_calil], [:libname_for_calil]) }
  end
end
