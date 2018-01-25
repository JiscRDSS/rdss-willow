class ObjectPersonRoleFormBuilder < RdssFields
  def role_type
    input :role_type, collection: ::RdssPersonRolesService.select_all_options, prompt: :translate, label: false
  end

  def destroy
    input :_destroy, as: :hidden, input_html:{ data: { destroy: true }, class: 'form-control remove-hidden', value: false}
  end
end