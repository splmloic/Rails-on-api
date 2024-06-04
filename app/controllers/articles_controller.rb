class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [ :update, :destroy]

  # GET /articles
  def index
    @articles = Article.all
    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # GET /articles/new
  def new
    @article = Article.new
    render json: @article
  end

  # POST /articles
  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def authorize_user!
    unless @article.user == current_user
      render json: { error: "You are not authorized to perform this action" }, status: :forbidden
    end
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
