class LoginController < ApplicationController
  def index
  end
  
  def auth
    pass=params[:Password]
    id=params[:user]
    session[:id]=id
    teacherFromDB=Teacher.where(:teacher_id => id, :password => pass).first
    unless teacherFromDB.nil?
      session[:group]=teacherFromDB.group
      session[:manager]=false
      redirect_to "/teachers/#{id}/choose_classes"
      return
    end
    managerFromDB=Manager.where(:manager_id => id).first
    if !managerFromDB.nil? && managerFromDB.password == pass
      session[:group]=managerFromDB.group
      session[:manager]=true
      redirect_to "/managers/options"
      return
    else
      flash[:notice] = Teacher.all.inspect # "Pair of login and password not found"
      redirect_to '/'
      return
    end
  end
  
  def logout
    session[:manager]=nil
    flash[:notice]="Thank you for using grades submission system"
    redirect_to '/'
  end
end
