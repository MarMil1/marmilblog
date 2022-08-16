class StaticPagesController < ApplicationController
  add_breadcrumb "Home", :articles_path
  def help
    add_breadcrumb "Help", static_pages_help_path
  end

  def contact
    add_breadcrumb "Contact", static_pages_contact_path
  end

  def about
    add_breadcrumb "About", static_pages_about_path
  end
end
