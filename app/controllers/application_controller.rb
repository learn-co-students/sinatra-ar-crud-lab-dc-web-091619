
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do 
    erb :new
  end

  get '/articles' do 
    @articles = Article.all

    erb :index
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])

    erb :edit
  end

  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.update(title: params[:title],
                    content: params[:content])
    
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)

    erb :show
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
    
    redirect '/articles'
  end

  post '/articles' do 
    new_article_title = params[:title]
    new_article_content = params[:content]

    @article = Article.create(title: new_article_title, content: new_article_content)

    redirect "/articles/#{@article.id}"
  end

end
