class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def logged_in?
    !session[:manager].nil?
  end
end
