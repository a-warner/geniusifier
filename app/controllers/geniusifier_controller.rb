class GeniusifierController < ApplicationController
  def create
    @markdown = params[:markdown].to_s
    @rendered = GeniusRenderer.render(@markdown).html_safe
    render 'show'
  end
end
