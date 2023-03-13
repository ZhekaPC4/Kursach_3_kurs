class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def new
    unless admin_or_editor
      redirect_to main_page_path
    end
  end

  def delete
    if admin_or_editor
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to main_page_path
    else
      redirect_to main_page_path
    end
  end

  def edit
    if admin_or_editor
      @article = Article.find(params[:id])
    else 
      redirect_to main_page_path
    end
  end

  def change
    if admin_or_editor
      @article = Article.find(params[:id])
      @article.update_columns(title: article_params[:title], text: article_params[:text])
      if @article.save
        redirect_to main_page_path
      else 
        flash[:edit_error] = "Ошибка изменения"
        redirect_to article_edit_path
      end
    else
      redirect_to main_page_path
    end
  end

  def create
    if admin_or_editor
      @article = Article.new(article_params)
      if @article.save
        redirect_to article_by_id_path(@article.id)
      else 
        raise @article.save!.inspect
        flash[:new_error] = "Ошибка сохранения"
      end
    else
      redirect_to main_page_path
    end
  end
  
  private
  # helpers.coding( ... )
  def article_params
    new_params = params.require(:article).permit(:title, :text, :author_id)
  end

end
