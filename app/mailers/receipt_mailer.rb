class ReceiptMailer < ActionMailer::Base
  default from: 'max@pixelsonrails.com'
  
  def receipt(sale)
    #@sale = sale
    #html = render_to_string('receipt_mailer/receipt.html')
    #pdf = Docverter::Conversion.run do |c|
    #  c.from = 'html'
    #  c.to = 'pdf'
    #  c.content = html
    #end
    #attachments['receipt.pdf'] = pdf
    #mail(to: sale.email_address, subject: 'Receipt for your purchase')
  end
end