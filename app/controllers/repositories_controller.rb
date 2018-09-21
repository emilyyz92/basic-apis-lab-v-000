class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
      req.params['q'] = params[:query]
      req.params['client_id'] = '60ca926f96b5123b1e7e'
      req.params['client_secret'] = '14cc2b5554ed98f52f86bbc9a5045c658f1dc179'
    end
    search_hash = JSON.parse(@resp.body)
    if @resp.success?
      binding.pry
      @items = search_hash['response']['items']
    else
      @error = 'Search Error - ' + search_hash['meta']['status']
    end
    render 'search'
  end

  private

  def repo_params
    params.require(:query).permit(:query)
  end
end
