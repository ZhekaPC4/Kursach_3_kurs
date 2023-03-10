class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  
  def new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_by_id_path(@article.id)
    else 
      raise @article.save!.inspect
      flash[:new_error] = "Ошибка сохранения"
    end
  end
  private
  # helpers.coding( ... )
  def article_params
    new_params = params.require(:article).permit(:title, :text, :author_id)
  end

end
