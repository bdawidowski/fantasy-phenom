class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :is_contributor?, except: [:show]
  before_action :is_thiers?, only: [:edit, :update]
  before_action :is_editor?, only: [:pending]
  before_action :is_admin?, only: [:destroy]
  # GET /articles
  # GET /articles.json
  def index
    if current_user.admin || current_user.editor
      @articles = Article.order(created_at: :desc)
    elsif current_user.contributor
      @articles = Article.where(:user_id => current_user.id)
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end
  
  def pending
    @articles = Article.where(:approved => false).order(created_at: :desc)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)

      if @article.save
        flash[:success] = "Article was created Successfully!"
        redirect_to article_path(@article)
      else
        render :new
      end
    
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
      if @article.update(article_params)
        flash[:success] = "Article was Successfully Updated!"
        redirect_to article_path(@article)
      else
       render :edit
      end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :image, :approved)
    end
    def is_thiers?
      if current_user.contributor? && !current_user.admin? && !current_user.editor?
        if current_user.id != @article.user_id
          flash[:danger] = "Editors & Admin Only!"
          redirect_to root_path
        end
      end
    end
end
