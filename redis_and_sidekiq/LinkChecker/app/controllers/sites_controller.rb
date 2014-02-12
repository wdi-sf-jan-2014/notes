class SitesController < ApplicationController
  def new
    @site = Site.new
  end

  def create
    url = params.require(:site)[:url]
    site = Site.create(url: url)
    LinksWorker.perform_async(site.id)
    redirect_to site_path(site)
  end

  def show
    @site = Site.find(params[:id])

    @links = @site.links
  end

  def linkfarm
  end
end
