class PeopleController < ApplicationController
  before_action :authenticate_person

  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      flash[:notice] = 'Person was successfully created.'
      redirect_to @person
    else
      render 'new'
    end
  end

  def update
    @person = Person.find(params[:id])

    if @person.update(person_params)
      flash[:notice] = 'Person was successfully updated.'
      redirect_to @person
    else
      render 'edit'
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    redirect_to people_path
  end

  private

  def person_params
    params.require(:person).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :date_of_birth,
      :gender
    )
  end
end
