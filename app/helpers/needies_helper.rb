module NeediesHelper
  
  def require_needy_login
    if !logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    elsif !is_needy?
      flash[:error] = "You must be registered as a person in need to access this section"
      redirect_to login_path
    end
  end

end
