class LoginController < ApplicationController
  def index
  end
  
  def auth
    pass=params[:Password]
    id=params[:user]
    teacherpassFromDB=Teacher.select(:password).where(:teacher_id => id)
    if !(teacherpassFromDB.nil? || teacherpassFromDB.empty?) && teacherpassFromDB.first.password == pass
      redirect_to "/teachers/#{id}/choose_classes"
    else 
      managerpassFromDB=Manager.select(:password).where(:manager_id => id)
      if !(managerpassFromDB.nil? || managerpassFromDB.empty?) && managerpassFromDB.first.password == pass
        redirect_to "/managers/#{id}/choose_classes"
      else
        flash[:notice] = "Pair of login and password not found"
        redirect_to "/"
      end
    end
  end
end
