# Controller for Home Page
class HomeController < ApplicationController
  before_action :require_user, only: [:index]

  def index
    @page_title = "Home"
  end
end
