class Manager < ActiveRecord::Base
  def self.deadline (group)
    deadline = Manager.select(:deadline).where(:group => group).first.deadline
    deadline = deadline.nil?? "Not setted yet" : deadline.to_date
  end 
end
