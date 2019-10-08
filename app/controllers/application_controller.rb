
require_relative '../../config/environment'

require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @all_articles = Article.all 
    erb :index

  end

  get '/articles/new' do
    @article = Article.new
    erb :new

  end

  post '/articles' do

    @article = Article.create(title: params["title"], content: params["content"])
    redirect "/articles/#{@article.id}"

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
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save

    redirect "/articles/#{@article.id}"
  end 

  delete "/delete/articles/:id" do

  @article = Article.find_by_id(params[:id])
  @article.delete

  redirect "/"

  end


end
