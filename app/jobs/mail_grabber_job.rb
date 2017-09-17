# require 'sidekiq-scheduler'
class MailGrabberJob
# class MailGrabberJob < ApplicationJob
  include Sidekiq::Worker
  include MailGrabberHelper
  # queue_as :default

  def perform
    MailGrabber.grab
  end
end
