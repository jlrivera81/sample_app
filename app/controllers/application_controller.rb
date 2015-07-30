class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # including this helper moduel will allow us to used all its functions across all models, controllers, and views
  include SessionsHelper
end
