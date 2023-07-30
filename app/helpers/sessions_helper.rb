module SessionsHelper

  # Returns the current logged-in user (if any).
  def current_user
    if is_donator?
      @current_user ||= Donator.find_by(id: session[:user_id])
    elsif is_needy?
      @current_user ||= Needy.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !!current_user
  end

  # Logs out the current user.
  def logout!
    session.clear
  end

  def which_user?
    session[:user_type]
  end

  def is_donator?
    which_user? == "donator"
  end

  def is_needy?
    which_user? == "needy"
  end

end
  