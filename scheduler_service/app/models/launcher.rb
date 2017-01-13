class Launcher < ActiveRecord::Base

  def self.start_task(params)
    response = {code: '200', body: {message: 'ok'}}
    begin
      load params[:executable_path]
    rescue ScriptError => e
      response[:code] = '422'
      response[:body][:message] = 'Error processing file ' + params[:executable_path] + ' :' + e.to_s
    end
    response
  end

end