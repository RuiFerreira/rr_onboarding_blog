class TagsController < ApplicationController
  before_action :set_tag, only: %I[edit update destroy]
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
    if @tag.destroy
      # TODO: end session here when implemented
      flash[:notice] = 'Tag successfully deleted'
      redirect_to tags_path
    else
      flash[:alert] = 'Tag could not be deleted'
      redirect_to 'show'
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end