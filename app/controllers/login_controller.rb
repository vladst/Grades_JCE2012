class LoginController < ApplicationController
  def index
  end
  
  def auth
    pass=params[:Password]
    id=params[:user]
    session[:id]=id
    teacherFromDB=Teacher.where(:teacher_id => id).where(:password => pass).first
    unless teacherFromDB.blank?
      session[:group]=teacherFromDB.group
      session[:manager]=false
      redirect_to "/teachers/#{id}/choose_classes"
      return
    end
    managerFromDB=Manager.where(:manager_id => id).where(:password => pass).first
    unless managerFromDB.blank?
      session[:group]=managerFromDB.group
      session[:manager]=true
      redirect_to "/managers/options"
      return
    end
    flash[:notice] = "Pair of login and password not found"
    redirect_to root_path
    return
  end
  
  def logout
    session[:manager]=nil
    flash[:notice]="Thank you for using grades submission system"
    redirect_to root_path
  end
end
