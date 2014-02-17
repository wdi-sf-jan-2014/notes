class SitesController < ApplicationController
  def new
    @site = Site.new
  end

  def create
    require 'open-uri'
    url = params.require(:site)[:url]
    site = Site.create(url: url)
    uri = URI.parse(url)
    domain = uri.scheme + '://' + uri.host
    domain += ':' + uri.port.to_s if uri.port != 80 && uri.port != 443
    contents = Nokogiri::HTML(open(url))
    contents.css('a').each do |link|
      link_href = link.attributes['href'].value
      if (link_href.starts_with? '/')
        link_href = domain + link_href
      end

      if (link_href.starts_with? 'http://', 'https://')
        response = Typhoeus.get(link_href)

        site.links.create(url: link_href, http_response: response.response_code)
      end  
    end

    redirect_to site_path(site)
  end

  def show
    @site = Site.find(params[:id])

    @links = @site.links
  end

  def linkfarm
  end
end
