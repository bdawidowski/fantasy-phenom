class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, except: [:show, :create, :ebook]
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

      respond_to do |format|
        if @contact.save 
            NotifyAdminEmail.new_contact(@contact).deliver
            format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
            format.json { render :show, status: :created, location: @contact }
        else
          flash[:danger] = "Sorry Please Try Again!"
           redirect_to root_path
        end
      end

  end


  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def ebook 
      @contact = Contact.new(contact_params)
      @contact.save
      if not User.find_by_email(params[:email])
          NotifyAdminEmail.new_lead(@contact).deliver
      end
      SendClientEmail.ebook(@contact).deliver
      flash[:success] = 'Check your email for the link to the PDF!'
      redirect_to root_path
  end
          
      

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.permit(:name, :email, :message)
    end
end
