class Admin::PagesController < Admin::HomeController
  respond_to :json, :html
  before_filter :load_resource, :only => [:edit, :update, :destroy]

  def index
    @pages = Page.order(:name)
    respond_with :admin, @pages
    #respond_to { |format| format.js }
  end

  def new
    @page = Page.new
    #respond_to { |format| format.js }
  end

  def create
    @page = Page.create(params[:page])
    respond_with :admin, @page
  end

  def edit
    #respond_to { |format| format.js }
  end

  def update
    @page.update_attributes params[:page]
    respond_with :admin, @page
  end

  def destroy
    @page.destroy
    respond_with :admin, @page
  end

  private #----

    def load_resource
      @page = Page.find params[:id]
    end

end