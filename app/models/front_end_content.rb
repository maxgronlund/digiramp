class FrontEndContent < ActiveRecord::Base
  
  def self.get_content
    mount_uploader :page_1_image,               ImageS3Uploader
    mount_uploader :page_3_image,               ImageS3Uploader
    mount_uploader :page_5_image_1,             ImageS3Uploader
    mount_uploader :page_5_image_2,             ImageS3Uploader
    mount_uploader :page_5_image_3,             ImageS3Uploader
    mount_uploader :page_5_image_4,             ImageS3Uploader
    mount_uploader :page_5_image_5,             ImageS3Uploader
    mount_uploader :page_5_image_6,             ImageS3Uploader
    mount_uploader :page_6_testimonial_1_image, ImageS3Uploader
    mount_uploader :page_6_testimonial_2_image, ImageS3Uploader
    mount_uploader :page_6_testimonial_3_image, ImageS3Uploader
    mount_uploader :page_6_testimonial_4_image, ImageS3Uploader
    mount_uploader :page_6_testimonial_5_image, ImageS3Uploader
    mount_uploader :page_7_image,               ImageS3Uploader

    

    self.where(identifyer: 'content')
        .first_or_create(
            identifyer: 'content',
            page1_title_1: 'Creativity',
            page1_title_2: 'Professional',
            page1_title_3: 'Business',
            page_1_body: 'Imagine a world where pure creative is the road to success. No need for: Promotion. Contracts. Layers. All people have equal opportunities. What really matters is the joy of music',
            page2_title: 'Let the music speak for it self',
            page_2_headline: 'DISTRIBUTE YOUR CONTENT IN A MANNER THAT BEST SUITS YOU AND YOUR AUDIENCE. MAKE BEAUTIFUL PROMOTION!',
            page_2_option_1_title: 'Manage all you assets',
            page_2_option_1_headline: 'ORIGINAL FILES, CONTRACTS, RIGHTS',
            page_2_option_1_body: 'A work has many users, interested parties tracks and fottage and more bla bla',
            page_2_option_2_title: 'Cloud Distribution',
            page_2_option_2_headline: 'AUTOMATE THE DISTRIBUTION',
            page_2_option_2_body: 'You can send playlists and widgets, emails and respond to opportunities',
            page_2_option_3_title: 'Connect with you audience',
            page_2_option_3_headline: 'GET FEEDBACK AND COMMENTS DIRECTLY',
            page_2_option_3_body: 'Connect music and feedback from music lovers directly to you creations',
            page_3_title: 'Get started right now!',
            page_3_headline: 'Try the creative account today and se how we help you promote your music across the net.',
            page_3_option_1_title: 'Present you work',
            page_3_option_1_body: 'Share music on social media and with you relatives using hour stylish customable widget',
            page_3_option_2_title: 'Profeccional usage',
            page_3_option_2_body: 'Share you businness and profit with you own network op profeccionals',
            page_4_title: 'Acount types',
            page_4_body: 'not anything yet',
            page_4_account_1_title: 'Creative',
            page_4_account_1_price: '0/month',
            page_4_account_1_option_1: '3 Hours Music',
            page_4_account_1_option_2: 'Unlimited Playlists',
            page_4_account_1_option_3: 'Unlimited Widgets',
            page_4_account_1_option_4: '1000 hours Streaming',
            page_4_account_1_option_5: 'Social features',
            page_4_account_1_option_5: '',
            page_4_account_1_option_6: '',
            page_4_account_2_title: 'Pro',
            page_4_account_2_price: '$19/month',
            page_4_account_2_option_1: 'Creative ++',
            page_4_account_2_option_2: 'Unlimited Works',
            page_4_account_2_option_3: 'Unlimited IPIs',
            page_4_account_2_option_4: '50 GB Storage',
            page_4_account_2_option_5: '',
            page_4_account_2_option_6: '',
            page_4_account_3_title: 'Business',
            page_4_account_3_price: '149/month',
            page_4_account_3_option_1: 'Pro ++',
            page_4_account_3_option_2: '100 Catalogs',
            page_4_account_3_option_3: 'Access management',
            page_4_account_3_option_4: '25 Users',
            page_4_account_3_option_5: 'CRM',
            page_4_account_3_option_6: 'Business Documents',
            page_4_account_4_title: 'Enterprice',
            page_4_account_4_price: 'Contact us',
            page_4_account_4_option_1: 'Business ++',
            page_4_account_4_option_2: 'Dedicated Server',
            page_4_account_4_option_3: 'Task Management',
            page_4_account_4_option_4: 'Deleviry DDEX',
            page_4_account_4_option_5: 'FTP',
            page_4_account_4_option_6: 'Workers',
            page_5_title: 'Application Screenshots',
            page_5_body: 'USE THIS AREA TO SHOWCASE SCREENSHOTS OF YOUR APP THE STRUCTURE IS SIMPLY, JUST ADD YOUR IMAGES AND DONE!',
            page_7_title: 'Perfect Marketing Theme',
            page_7_headline: 'WE ARE ESPECIALLY BEAUTIFUL AND FULLY RESPONSIVE',
            page_7_body: 'Lorem ipsum dolor sit amet, consectetur Morbi sagittis, sem quis lacinia faucibus, orci ipsum gravida tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sagittis, sem quis lacinia faucibus, orci ipsum gravida tortor. Nulla varius consequat magna, id molestie ipsum volutpat quis. Suspendisse consectetur fringilla suctus. Pellentesque ipsum erat, facilisis ut venenatis eu, sodales vel dolor quis lacinia faucibus, orci ipsum gravida tortor.',
            page_8_title: 'Contact', 
            page_8_body:'OUR TECHNICAL SUPPORT TEAMS STAND READY TO ASSIST YOU WITH ALL OF YOUR TECHNICAL QUESTIONS CONCERNING APULUM'
          
          )
  end
end



