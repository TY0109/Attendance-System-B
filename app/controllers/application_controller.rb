class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  
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

  
