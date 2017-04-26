class ContactController < ApplicationController
  before_action :set_default_response_format

  def create
    @contact = Contact.new
    @contact.name = params[:fullNmae]
    @contact.email = params[:email]
    @contact.txt = params[:message]
    @contact.save
    respond_to do |format|
      format.html
      format.json {render json: {txt: 'ok'}}
    end
  end

 private

  def set_default_response_format
    request.format = :json
  end

end
