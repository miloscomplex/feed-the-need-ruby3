module DonatorsHelper

  def require_donator_login
    if !logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    elsif !is_donator?
      flash[:error] = "You must be registered as a donator access this section"
      redirect_to login_path
    end
  end

end
