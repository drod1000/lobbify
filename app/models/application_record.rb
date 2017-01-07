class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  self.abstract_class = true
end
