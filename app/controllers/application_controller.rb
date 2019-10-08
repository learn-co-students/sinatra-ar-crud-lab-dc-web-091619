
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  #a form for the user to be able to create a new article
  get '/articles/new' do 
    
    erb :new
  end 

  get '/articles' do
    @articles = Article.all 
    erb :index #iterate over array 
  end 

  post '/articles' do 
    @article = Article.create(title: params[:title], content: params[:content])

    redirect ("/articles/#{@article.id}")
  end 

  get '/articles/:id' do

    @article = Article.find(params[:id]) 
    erb :show
  end 

  get '/articles/:id/edit' do 

    @article = Article.find(params[:id])
    erb :edit
  end 

  patch '/articles/:id' do 
    @article = Article.find(params[:id])

    title = params["title"]
    content = params["content"]

    @article.update(title: title, content: content)

    redirect ("/articles/#{@article.id}")
  end 

  delete '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.destroy

    redirect ("/articles")
  end

end
