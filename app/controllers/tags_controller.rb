class TagsController < ApplicationController
  before_action :set_tag, only: %I[show edit update]
  def index
    @tags = Tag.all
  end

  def show
    set_tag
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = 'Tag was successfully created'
      redirect_to @tag
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @tag.update(tag_params)
      flash[:notice] = 'Tag edited successfully'
      redirect_to tag_path
    else
      render 'edit'
    end
  end

  def destroy; end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end