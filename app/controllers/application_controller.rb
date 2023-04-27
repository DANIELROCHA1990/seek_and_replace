class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :permit_file_upload

  private

  def permit_file_upload
    params.permit(:pdf_path) if request.post?
  end
end
