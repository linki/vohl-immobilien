  def destroy
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    @<%= singular_name %>.destroy
    flash[:notice] = "<%= name.humanize.titleize %> erfolgreich gelöscht."
    redirect_to <%= plural_name %>_url
  end
