class LoginController < ApplicationController
  def index
  end
  
  def auth
    pass=params[:Password]
    id=params[:user]
    session[:id]=id
    teacherpassFromDB=Teacher.where(:teacher_id => id).first
    if !(teacherpassFromDB.nil?) && teacherpassFromDB.password == pass
      session[:group]=teacherpassFromDB.group
      session[:manager]=false
      redirect_to "/teachers/#{id}/choose_classes"
    else 
      managerpassFromDB=Manager.where(:manager_id => id).first
      if !managerpassFromDB.nil? && managerpassFromDB.password == pass
        session[:group]=managerpassFromDB.group
        session[:manager]=true
        redirect_to "/managers/#{id}/choose_classes"
      else
        flash[:notice] = "Pair of login and password not found"
        redirect_to "/"
      end
    end
  end
end
