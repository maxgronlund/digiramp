class UpdateNameOnPersonalPublishingAgreements < ActiveRecord::Migration
  def up

    #template = Document.cached_find('8d96ed60-5dd5-11e5-b2ca-60334bfffe81')
    #
    #
    #
    #PublishingAgreement.where(personal_agreement: true).find_each do |publishing_agreement|
    #  
    #  publishing_agreement.update(account_id: publishing_agreement.publisher.account_id)
    #  user = publishing_agreement.account.user
    #  publishing_agreement.documents.destroy_all
    #  
    #  doc = CopyMachine.copy_document( template )
    #  doc.update( 
    #      :belongs_to_id    => publishing_agreement.id,
    #      :belongs_to_type  => publishing_agreement.class.name,
    #      :account_id       => publishing_agreement.account_id,
    #      :template_id      => template.id,
    #      document_type:    'Publishing',
    #      title:            'Self publishing',
    #      expires: false
    #  )
    #  
    #  template.digital_signatures.each do |digital_signature|
    #    document_user = DocumentUser.create(
    #      :document_id => doc.uuid,
    #        :user_id => user.id,
    #     :account_id => publishing_agreement.account_id,
    #       :can_edit => true,
    #    :should_sign => true,
    #          :email => user.email,
    #           :role => digital_signature.role,
    #     :legal_name => user.first_name
    #
    #    )
    #    
    #    #signature = CopyMachine.copy_signature( digital_signature )
    #    #signature.update(
    #    #  signable_id:    doc.id,
    #    #  signable_type:  doc.class.name,
    #    #  user_id:        user.id,
    #    #  email:          user.email
    #    #)
    #    #
    #    
    #  end  
    #end
  end
  
  def down

  end
end
