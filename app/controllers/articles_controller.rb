class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    if !current_user.present?
      redirect_to main_page_path
    elsif current_user.role != "admin" && current_user.role != "editor"
      redirect_to main_page_path
    end
  end

  def delete
    if !current_user.present?
      redirect_to main_page_path
    elsif current_user.role != "admin" && current_user.role != "editor"
      redirect_to main_page_path
    else
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to main_page_path
    end
  end

  def edit
    if !current_user.present?
      redirect_to main_page_path
    elsif current_user.role != "admin" && current_user.role != "editor"
      redirect_to main_page_path
    else
      @article = Article.find(params[:id])
    end
  end

  def change
    if !current_user.present?
      redirect_to main_page_path
    elsif current_user.role != "admin" && current_user.role != "editor"
      redirect_to main_page_path
    else
      @article = Article.find(params[:id])
      @article.update_columns(title: article_params[:title], text: article_params[:text])
      if @article.save
        redirect_to main_page_path
      else 
        flash[:edit_error] = "Ошибка изменения"
        redirect_to article_edit_path
      end
    end
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
