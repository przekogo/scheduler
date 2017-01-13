class LauncherController < ApplicationController
  before_action :check_service_token
  skip_before_action :verify_authenticity_token

  def start_task
    result = Launcher.start_task(launcher_params)
    render status: result[:code], json: result[:body].to_json
  end

  private

    def check_service_token
      unless launcher_params[:token] == ::TOKEN
        render status: :unauthorized, json: {message: 'token invalid'}.to_json
      end
    end

    def launcher_params
      params.require(:task).permit(:executable_path, :token)
    end

end