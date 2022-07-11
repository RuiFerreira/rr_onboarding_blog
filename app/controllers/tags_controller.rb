class TagsController < ApplicationController
  before_action :set_tag, only: %I[edit update destroy]
  before_action :validate_session
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = 'Tag was successfully created'
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      flash[:notice] = 'Tag edited successfully'
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    if @tag.articles.count.zero? && @tag.destroy
      flash[:notice] = 'Tag successfully deleted'
    else
      flash[:alert] = 'Tag could not be deleted. Please delete its articles.'
    end
    redirect_to tags_path
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end