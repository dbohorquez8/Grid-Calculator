require 'rubygems'
require 'sinatra'
require './environment'

mime_type :ttf, "application/octet-stream"
mime_type :woff, "application/octet-stream"

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  set :public, "#{File.dirname(__FILE__)}/public"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  def partial(template, options = {})
    options.merge!(:layout => false)
    haml("shared/#{template}".to_sym, options)
  end
end

get '/shared/:page_name' do
  @page_name = params[:page_name]
  haml "shared/#{@page_name}".to_sym, :layout => false
end

get '/:folder/:page_name' do
  @page_name = params[:page_name]
  @folder = params[:folder]
  haml "#{@folder}/#{@page_name}".to_sym, :layout => :'layouts/main'
end

get '/:page_name' do
  @page_name = params[:page_name]
  haml @page_name.to_sym, :layout => :'layouts/main'
end

get '/' do
  @page_name = 'home'
  @wrapper_width = params[:wrapper_width].to_f
  @gutter_width = params[:gutter_width].to_f
  @wrapper_margin = params[:wrapper_margin].to_f

  # Wrapper
  @wrapper_real_width = @wrapper_width - @wrapper_margin*2

  #Gutter
  @gutter_width_percent = @gutter_width*100/@wrapper_real_width

  #Base Columns
  @half = (100 - @gutter_width_percent)/2
  @third = (100 - @gutter_width_percent*2)/3
  @quarter = (100 - @gutter_width_percent*3)/4
  @fifth = (100 - @gutter_width_percent*4)/5
  @sixth = (100 - @gutter_width_percent*5)/6

  #Column Multiples
  @twothird = @third*2 + @gutter_width_percent
  @threequarter = @quarter*3 + @gutter_width_percent*2
  @twofifth = @fifth*2 + @gutter_width_percent
  @threefifth = @fifth*3 + @gutter_width_percent*2
  @fourfifth = @fifth*4 + @gutter_width_percent*3
  @fivesixth = @sixth*5 + @gutter_width_percent*4

  #Offsets
  @push_half = @half + @gutter_width_percent
  @push_third = @third + @gutter_width_percent
  @push_quarter = @quarter + @gutter_width_percent
  @push_fifth = @fifth + @gutter_width_percent
  @push_sixth = @sixth + @gutter_width_percent
  @push_twothird = @twothird + @gutter_width_percent
  @push_threequarter = @threequarter + @gutter_width_percent
  @push_twofifth = @twofifth + @gutter_width_percent
  @push_threefifth = @threefifth + @gutter_width_percent
  @push_fourfifth = @fourfifth + @gutter_width_percent
  @push_fivesixth = @fivesixth + @gutter_width_percent

  #split

  haml :index, :layout => :'layouts/main'
end
