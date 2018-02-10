# The controller for Administration Rights
class AdminPagesController < ApplicationController
  before_action :require_admin, only: [:index]

  def index
    @page_title = "Admin Pages"
  end
end
