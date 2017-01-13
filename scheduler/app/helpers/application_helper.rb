module ApplicationHelper
  
  def task_response_class(responses)
    if responses.blank? #no responses yet
      ''
    elsif responses.first['code'] == '200' #last response succeess
      'background-success clickable'
    else #last response fail
      'background-fail clickable' 
    end
  end

  def task_response_popover(responses)
    if responses.blank?
      return
    end
    responses.map{|h| h.map{|k,v| if k=='created_at' then v.localtime.strftime('%Y-%m-%d %H:%M:%S')+'</br>' else v end}.join(' ')}.join('<hr>')
  end
end
