class CoursesController < ApplicationController
  require 'will_paginate/array' 
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :search_course, only: [:index, :search, :show]
  
  
  def search
    
  end

  def index
    @reviews = Review.where(course_id: @course)
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
    if @reviews.blank?
      @avg_review2 = 0
    else
      @avg_review2 = @reviews.average(:rating2).round(2)
    end
    if @reviews.blank?
      @avg_review3 = 0
    else
      @avg_review3 = @reviews.average(:rating3).round(2)
    end
  end

  def show
    @reviews = Review.where(course_id: @course.id).order("created_at DESC")
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
    if @reviews.blank?
      @avg_review2 = 0
    else
      @avg_review2 = @reviews.average(:rating2).round(2)
    end
    if @reviews.blank?
      @avg_review3 = 0
    else
      @avg_review3 = @reviews.average(:rating3).round(2)
    end
  end

  def new
    @course = current_user.courses.build
  end
  
  def edit
  end

  def create
    @course = current_user.courses.build(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:code, :name, :description)
    end
    
    def search_course
      if params[:search].present?
        @courses = Course.search(params[:search], page: params[:page], per_page: 3)
      else
        @courses = Course.paginate(page: params[:page], per_page: 3)
      end
    end
    
end