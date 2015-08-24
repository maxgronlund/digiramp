class BlockRegister < ActiveRecord::Base
  
  require 'blockchain'
  
  
  def self.send_to_block
   
    #str = bin_to_hex("Street art plaid post-ironic gluten-free, four dollar toast Austin Schlitz Bushwick yr sustainable aesthetic. Ethical flexitarian cronut American Apparel. VHS 3 wolf moon YOLO, flexitarian cold-pressed try-hard chillwave small batch. Shoreditch flannel put a bird on it narwhal raw denim viral gluten-free Brooklyn you probably haven't heard of them. XOXO sartorial normcore taxidermy Tumblr, fanny pack biodiesel 3 wolf moon street art meditation selfies Godard. Ennui whatever Etsy food truck viral American Apparel salvia fixie, gastropub tilde. Keffiyeh crucifix direct trade, trust fund plaid American Apparel High Life drinking vinegar slow-carb single-origin coffee quinoa try-hard umami.")
    #ap str
    #block_register = BlockRegister.create(secret: SecureRandom.hex( 128 ))
    #ap Blockchain::pushtx( str )
    ap Blockchain::pushtx( '0100000001fd468e431cf5797b108e4d22724e1e055b3ecec59af4ef17b063afd36d3c5cf6010000008c4930460221009918eee8be186035be8ca573b7a4ef7bc672c59430785e5390cc375329a2099702210085b86387e3e15d68c847a1bdf786ed0fdbc87ab3b7c224f3c5490ac19ff4e756014104fe2cfcf0733e559cbf28d7b1489a673c0d7d6de8470d7ff3b272e7221afb051b777b5f879dd6a8908f459f950650319f0e83a5cf1d7c1dfadf6458f09a84ba80ffffffff01185d2033000000001976a9144be9a6a5f6fb75765145d9c54f1a4929e407d2ec88ac00000000')
  end
  
  def self.bin_to_hex(s)
    s.each_byte.map { |b| b.to_s(16) }.join
  end
  
  
end
