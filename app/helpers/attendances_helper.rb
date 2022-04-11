module AttendancesHelper
  def attendance_state(attendance)
    if Date.current==attendance.worked_on
      return '出社' if attendance.started_at.nil?
      return '退社' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    false
  end
  
  
  def working_times(start,finish)
    format("%.2f", ((finish-start)/60)/60.0)
  end
  
  def attendances_invalid?
    attendances=true
    attendances_params.each do |id,item|
     if item[:started_at].blank? && item[:finished_at].blank?
       next
     elsif item[:started_at].present? && item[:finished_at].present?
       next
     elsif item[:started_at].blank? || item[:finshed_at].blank?
       attendances=false
       break
     end
    end
    return attendances
  end

end
