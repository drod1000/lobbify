class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

end
