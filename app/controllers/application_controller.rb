class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  $days_of_the_week=%w{日 月 火 水 木 金 土}
  
  def set_one_month
    @first_day=Date.current.beginning_of_month
    @last_day=@first_day.end_of_month
    one_month=[*@first_day..@last_day]
    @attendances=@user.attendances.where(worked_on:@first_day..@last_day).order(:worked_on)
    
    unless one_month.count==@attendances.count
      ActiveRecord::Base.transaction do
        one_month.each {|day|@user.attendances.create!(worked_on:day)}
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger]="ページの情報の取得に失敗しました。再アクセスしてください。"
    redirect_to root_url
  end
  
  
  def set_user
    @user=User.find(params[:id])
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger]="ログインしてしてください。"
      redirect_to login_url
    end
  end
      
  def correct_user
    unless current_user?(@user)
    flash[:danger]="権限がありません。"
    redirect_to(root_url)
    end
  end
  
  
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
  
  def admin_or_correct_user
    unless current_user?(@user) || current_user.admin?
     flash[:danger]="権限がありません。"
     redirect_to(root_url)
    end
  end
    
end

  
