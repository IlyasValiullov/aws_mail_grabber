class MessageController < ApplicationController
  include MailGrabberHelper
  def index
    @bounces = Message.where(message_type: "Bounce").order(date: :desc)
    @complaints = Message.where(message_type: "Complaint").order(date: :desc)
  end

  def show
    @message = Message.find(params[:id])
    render json: JSON.pretty_generate(JSON.parse(@message.source))
  end

  def grab
    MailGrabber.grab
    head :ok
  end
end
