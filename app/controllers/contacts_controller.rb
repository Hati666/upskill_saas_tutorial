class ContactsController < ApplicationController
   def new
     @contact = Contact.new
   end
   def create
     @contact = Contact.new(contact_params)
     if @contact.save
        flash[:success] = "Message sent."
        name = param[:contact][:name]
        email = param[:contact][:email]
        body = param[:contact][:body]
        ContactMailer.contact_email(name, email, body).deliver
        redirect_to new_contact_path, notice: "Message sent."
     else
        flash[:danger] = @contact.errors.full_messages.join(", ")
        redirect_to new_contact_path
     end
   end
   private
     def contact_params
        params.require(:contact).permit(:name, :email, :comments)
     end
end